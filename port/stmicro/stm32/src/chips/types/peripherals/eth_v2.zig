const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Ethernet Peripheral
pub const ETH = extern struct {
    /// Ethernet: media access control (MAC)
    /// offset: 0x00
    ETHERNET_MAC: u32,
    /// offset: 0x04
    reserved4: [3068]u8,
    /// Ethernet: MTL mode register (MTL)
    /// offset: 0xc00
    ETHERNET_MTL: u32,
    /// offset: 0xc04
    reserved3076: [1020]u8,
    /// Ethernet: DMA mode register (DMA)
    /// offset: 0x1000
    ETHERNET_DMA: u32,
};

/// Ethernet: DMA mode register (DMA)
pub const ETHERNET_DMA = extern struct {
    /// DMA mode register
    /// offset: 0x00
    DMAMR: mmio.Mmio(packed struct(u32) {
        /// Software Reset
        SWR: u1,
        /// DMA Tx or Rx Arbitration Scheme
        DA: u1,
        reserved11: u9 = 0,
        /// Transmit priority
        TXPR: u1,
        /// Priority ratio
        PR: u3,
        reserved16: u1 = 0,
        /// Interrupt Mode
        INTM: u2,
        padding: u14 = 0,
    }),
    /// System bus mode register
    /// offset: 0x04
    DMASBMR: mmio.Mmio(packed struct(u32) {
        /// Fixed Burst Length
        FB: u1,
        reserved12: u11 = 0,
        /// Address-Aligned Beats
        AAL: u1,
        reserved14: u1 = 0,
        /// Mixed Burst
        MB: u1,
        /// Rebuild INCRx Burst
        RB: u1,
        padding: u16 = 0,
    }),
    /// Interrupt status register
    /// offset: 0x08
    DMAISR: mmio.Mmio(packed struct(u32) {
        /// DMA Channel Interrupt Status
        DC0IS: u1,
        reserved16: u15 = 0,
        /// MTL Interrupt Status
        MTLIS: u1,
        /// MAC Interrupt Status
        MACIS: u1,
        padding: u14 = 0,
    }),
    /// Debug status register
    /// offset: 0x0c
    DMADSR: mmio.Mmio(packed struct(u32) {
        /// AHB Master Write Channel
        AXWHSTS: u1,
        reserved8: u7 = 0,
        /// DMA Channel Receive Process State
        RPS0: u4,
        /// DMA Channel Transmit Process State
        TPS0: u4,
        padding: u16 = 0,
    }),
    /// offset: 0x10
    reserved16: [240]u8,
    /// Channel control register
    /// offset: 0x100
    DMACCR: mmio.Mmio(packed struct(u32) {
        /// Maximum Segment Size
        MSS: u14,
        reserved16: u2 = 0,
        /// 8xPBL mode
        PBLX8: u1,
        reserved18: u1 = 0,
        /// Descriptor Skip Length
        DSL: u3,
        padding: u11 = 0,
    }),
    /// Channel transmit control register
    /// offset: 0x104
    DMACTxCR: mmio.Mmio(packed struct(u32) {
        /// Start or Stop Transmission Command
        ST: u1,
        reserved4: u3 = 0,
        /// Operate on Second Packet
        OSF: u1,
        reserved12: u7 = 0,
        /// TCP Segmentation Enabled
        TSE: u1,
        reserved16: u3 = 0,
        /// Transmit Programmable Burst Length
        TXPBL: u6,
        padding: u10 = 0,
    }),
    /// Channel receive control register
    /// offset: 0x108
    DMACRxCR: mmio.Mmio(packed struct(u32) {
        /// Start or Stop Receive Command
        SR: u1,
        /// Receive Buffer size
        RBSZ: u14,
        reserved16: u1 = 0,
        /// RXPBL
        RXPBL: u6,
        reserved31: u9 = 0,
        /// DMA Rx Channel Packet Flush
        RPF: u1,
    }),
    /// offset: 0x10c
    reserved268: [8]u8,
    /// Channel Tx descriptor list address register
    /// offset: 0x114
    DMACTxDLAR: mmio.Mmio(packed struct(u32) {
        /// Start of Transmit List
        TDESLA: u32,
    }),
    /// offset: 0x118
    reserved280: [4]u8,
    /// Channel Rx descriptor list address register
    /// offset: 0x11c
    DMACRxDLAR: mmio.Mmio(packed struct(u32) {
        /// Start of Receive List
        RDESLA: u32,
    }),
    /// Channel Tx descriptor tail pointer register
    /// offset: 0x120
    DMACTxDTPR: mmio.Mmio(packed struct(u32) {
        /// Transmit Descriptor Tail Pointer
        TDT: u32,
    }),
    /// offset: 0x124
    reserved292: [4]u8,
    /// Channel Rx descriptor tail pointer register
    /// offset: 0x128
    DMACRxDTPR: mmio.Mmio(packed struct(u32) {
        /// Receive Descriptor Tail Pointer
        RDT: u32,
    }),
    /// Channel Tx descriptor ring length register
    /// offset: 0x12c
    DMACTxRLR: mmio.Mmio(packed struct(u32) {
        /// Transmit Descriptor Ring Length
        TDRL: u10,
        padding: u22 = 0,
    }),
    /// Channel Rx descriptor ring length register
    /// offset: 0x130
    DMACRxRLR: mmio.Mmio(packed struct(u32) {
        /// Receive Descriptor Ring Length
        RDRL: u10,
        padding: u22 = 0,
    }),
    /// Channel interrupt enable register
    /// offset: 0x134
    DMACIER: mmio.Mmio(packed struct(u32) {
        /// Transmit Interrupt Enable
        TIE: u1,
        /// Transmit Stopped Enable
        TXSE: u1,
        /// Transmit Buffer Unavailable Enable
        TBUE: u1,
        reserved6: u3 = 0,
        /// Receive Interrupt Enable
        RIE: u1,
        /// Receive Buffer Unavailable Enable
        RBUE: u1,
        /// Receive Stopped Enable
        RSE: u1,
        /// Receive Watchdog Timeout Enable
        RWTE: u1,
        /// Early Transmit Interrupt Enable
        ETIE: u1,
        /// Early Receive Interrupt Enable
        ERIE: u1,
        /// Fatal Bus Error Enable
        FBEE: u1,
        /// Context Descriptor Error Enable
        CDEE: u1,
        /// Abnormal Interrupt Summary Enable
        AIE: u1,
        /// Normal Interrupt Summary Enable
        NIE: u1,
        padding: u16 = 0,
    }),
    /// Channel Rx interrupt watchdog timer register
    /// offset: 0x138
    DMACRxIWTR: mmio.Mmio(packed struct(u32) {
        /// Receive Interrupt Watchdog Timer Count
        RWT: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x13c
    reserved316: [8]u8,
    /// Channel current application transmit descriptor register
    /// offset: 0x144
    DMACCATxDR: mmio.Mmio(packed struct(u32) {
        /// Application Transmit Descriptor Address Pointer
        CURTDESAPTR: u32,
    }),
    /// offset: 0x148
    reserved328: [4]u8,
    /// Channel current application receive descriptor register
    /// offset: 0x14c
    DMACCARxDR: mmio.Mmio(packed struct(u32) {
        /// Application Receive Descriptor Address Pointer
        CURRDESAPTR: u32,
    }),
    /// offset: 0x150
    reserved336: [4]u8,
    /// Channel current application transmit buffer register
    /// offset: 0x154
    DMACCATxBR: mmio.Mmio(packed struct(u32) {
        /// Application Transmit Buffer Address Pointer
        CURTBUFAPTR: u32,
    }),
    /// offset: 0x158
    reserved344: [4]u8,
    /// Channel current application receive buffer register
    /// offset: 0x15c
    DMACCARxBR: mmio.Mmio(packed struct(u32) {
        /// Application Receive Buffer Address Pointer
        CURRBUFAPTR: u32,
    }),
    /// Channel status register
    /// offset: 0x160
    DMACSR: mmio.Mmio(packed struct(u32) {
        /// Transmit Interrupt
        TI: u1,
        /// Transmit Process Stopped
        TPS: u1,
        /// Transmit Buffer Unavailable
        TBU: u1,
        reserved6: u3 = 0,
        /// Receive Interrupt
        RI: u1,
        /// Receive Buffer Unavailable
        RBU: u1,
        /// Receive Process Stopped
        RPS: u1,
        /// Receive Watchdog Timeout
        RWT: u1,
        /// Early Transmit Interrupt
        ET: u1,
        /// Early Receive Interrupt
        ER: u1,
        /// Fatal Bus Error
        FBE: u1,
        /// Context Descriptor Error
        CDE: u1,
        /// Abnormal Interrupt Summary
        AIS: u1,
        /// Normal Interrupt Summary
        NIS: u1,
        /// Tx DMA Error Bits
        TEB: u3,
        /// Rx DMA Error Bits
        REB: u3,
        padding: u10 = 0,
    }),
    /// offset: 0x164
    reserved356: [8]u8,
    /// Channel missed frame count register
    /// offset: 0x16c
    DMACMFCR: mmio.Mmio(packed struct(u32) {
        /// Dropped Packet Counters
        MFC: u11,
        reserved15: u4 = 0,
        /// Overflow status of the MFC Counter
        MFCO: u1,
        padding: u16 = 0,
    }),
};

/// Ethernet: media access control (MAC)
pub const ETHERNET_MAC = extern struct {
    /// Operating mode configuration register
    /// offset: 0x00
    MACCR: mmio.Mmio(packed struct(u32) {
        /// Receiver Enable
        RE: u1,
        /// Transmitter Enable
        TE: u1,
        /// Preamble Length for Transmit Packets
        PRELEN: u2,
        /// Deferral Check
        DC: u1,
        /// Back-Off Limit
        BL: u2,
        reserved8: u1 = 0,
        /// Disable Retry
        DR: u1,
        /// Disable Carrier Sense During Transmission
        DCRS: u1,
        /// Disable Receive Own
        DO: u1,
        /// Enable Carrier Sense Before Transmission in Full-Duplex Mode
        ECRSFD: u1,
        /// Loopback Mode
        LM: u1,
        /// Duplex Mode
        DM: u1,
        /// MAC Speed
        FES: u1,
        reserved16: u1 = 0,
        /// Jumbo Packet Enable
        JE: u1,
        /// Jabber Disable
        JD: u1,
        reserved19: u1 = 0,
        /// Watchdog Disable
        WD: u1,
        /// Automatic Pad or CRC Stripping
        ACS: u1,
        /// CRC stripping for Type packets
        CST: u1,
        /// IEEE 802.3as Support for 2K Packets
        S2KP: u1,
        /// Giant Packet Size Limit Control Enable
        GPSLCE: u1,
        /// Inter-Packet Gap
        IPG: u3,
        /// Checksum Offload
        IPC: u1,
        /// Source Address Insertion or Replacement Control
        SARC: u3,
        /// ARP Offload Enable
        ARPEN: u1,
    }),
    /// Extended operating mode configuration register
    /// offset: 0x04
    MACECR: mmio.Mmio(packed struct(u32) {
        /// Giant Packet Size Limit
        GPSL: u14,
        reserved16: u2 = 0,
        /// Disable CRC Checking for Received Packets
        DCRCC: u1,
        /// Slow Protocol Detection Enable
        SPEN: u1,
        /// Unicast Slow Protocol Packet Detect
        USP: u1,
        reserved24: u5 = 0,
        /// Extended Inter-Packet Gap Enable
        EIPGEN: u1,
        /// Extended Inter-Packet Gap
        EIPG: u5,
        padding: u2 = 0,
    }),
    /// Packet filtering control register
    /// offset: 0x08
    MACPFR: mmio.Mmio(packed struct(u32) {
        /// Promiscuous Mode
        PR: u1,
        /// Hash Unicast
        HUC: u1,
        /// Hash Multicast
        HMC: u1,
        /// DA Inverse Filtering
        DAIF: u1,
        /// Pass All Multicast
        PM: u1,
        /// Disable Broadcast Packets
        DBF: u1,
        /// Pass Control Packets
        PCF: u2,
        /// SA Inverse Filtering
        SAIF: u1,
        /// Source Address Filter Enable
        SAF: u1,
        /// Hash or Perfect Filter
        HPF: u1,
        reserved16: u5 = 0,
        /// VLAN Tag Filter Enable
        VTFE: u1,
        reserved20: u3 = 0,
        /// Layer 3 and Layer 4 Filter Enable
        IPFE: u1,
        /// Drop Non-TCP/UDP over IP Packets
        DNTU: u1,
        reserved31: u9 = 0,
        /// Receive All
        RA: u1,
    }),
    /// Watchdog timeout register
    /// offset: 0x0c
    MACWTR: mmio.Mmio(packed struct(u32) {
        /// Watchdog Timeout
        WTO: u4,
        reserved8: u4 = 0,
        /// Programmable Watchdog Enable
        PWE: u1,
        padding: u23 = 0,
    }),
    /// Hash Table 0/1 register
    /// offset: 0x10
    MACHTR: [2]mmio.Mmio(packed struct(u32) {
        /// MAC Hash Table 32 Bits
        HT: u32,
    }),
    /// offset: 0x18
    reserved24: [56]u8,
    /// VLAN tag register
    /// offset: 0x50
    MACVTR: mmio.Mmio(packed struct(u32) {
        /// VLAN Tag Identifier for Receive Packets
        VL: u16,
        /// Enable 12-Bit VLAN Tag Comparison
        ETV: u1,
        /// VLAN Tag Inverse Match Enable
        VTIM: u1,
        /// Enable S-VLAN
        ESVL: u1,
        /// Enable Receive S-VLAN Match
        ERSVLM: u1,
        /// Disable VLAN Type Check
        DOVLTC: u1,
        /// Enable VLAN Tag Stripping on Receive
        EVLS: u2,
        reserved24: u1 = 0,
        /// Enable VLAN Tag in Rx status
        EVLRXS: u1,
        /// VLAN Tag Hash Table Match Enable
        VTHM: u1,
        /// Enable Double VLAN Processing
        EDVLP: u1,
        /// Enable Inner VLAN Tag
        ERIVLT: u1,
        /// Enable Inner VLAN Tag Stripping on Receive
        EIVLS: u2,
        reserved31: u1 = 0,
        /// Enable Inner VLAN Tag in Rx Status
        EIVLRXS: u1,
    }),
    /// offset: 0x54
    reserved84: [4]u8,
    /// VLAN Hash table register
    /// offset: 0x58
    MACVHTR: mmio.Mmio(packed struct(u32) {
        /// VLAN Hash Table
        VLHT: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x5c
    reserved92: [4]u8,
    /// VLAN inclusion register
    /// offset: 0x60
    MACVIR: mmio.Mmio(packed struct(u32) {
        /// VLAN Tag for Transmit Packets
        VLT: u16,
        /// VLAN Tag Control in Transmit Packets
        VLC: u2,
        /// VLAN Priority Control
        VLP: u1,
        /// C-VLAN or S-VLAN
        CSVL: u1,
        /// VLAN Tag Input
        VLTI: u1,
        padding: u11 = 0,
    }),
    /// Inner VLAN inclusion register
    /// offset: 0x64
    MACIVIR: mmio.Mmio(packed struct(u32) {
        /// VLAN Tag for Transmit Packets
        VLT: u16,
        /// VLAN Tag Control in Transmit Packets
        VLC: u2,
        /// VLAN Priority Control
        VLP: u1,
        /// C-VLAN or S-VLAN
        CSVL: u1,
        /// VLAN Tag Input
        VLTI: u1,
        padding: u11 = 0,
    }),
    /// offset: 0x68
    reserved104: [8]u8,
    /// Tx Queue flow control register
    /// offset: 0x70
    MACQTxFCR: mmio.Mmio(packed struct(u32) {
        /// Flow Control Busy or Backpressure Activate
        FCB_BPA: u1,
        /// Transmit Flow Control Enable
        TFE: u1,
        reserved4: u2 = 0,
        /// Pause Low Threshold
        PLT: u3,
        /// Disable Zero-Quanta Pause
        DZPQ: u1,
        reserved16: u8 = 0,
        /// Pause Time
        PT: u16,
    }),
    /// offset: 0x74
    reserved116: [28]u8,
    /// Rx flow control register
    /// offset: 0x90
    MACRxFCR: mmio.Mmio(packed struct(u32) {
        /// Receive Flow Control Enable
        RFE: u1,
        /// Unicast Pause Packet Detect
        UP: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x94
    reserved148: [28]u8,
    /// Interrupt status register
    /// offset: 0xb0
    MACISR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// PHY Interrupt
        PHYIS: u1,
        /// PMT Interrupt Status
        PMTIS: u1,
        /// LPI Interrupt Status
        LPIIS: u1,
        reserved8: u2 = 0,
        /// MMC Interrupt Status
        MMCIS: u1,
        /// MMC Receive Interrupt Status
        MMCRXIS: u1,
        /// MMC Transmit Interrupt Status
        MMCTXIS: u1,
        reserved12: u1 = 0,
        /// Timestamp Interrupt Status
        TSIS: u1,
        /// Transmit Status Interrupt
        TXSTSIS: u1,
        /// Receive Status Interrupt
        RXSTSIS: u1,
        padding: u17 = 0,
    }),
    /// Interrupt enable register
    /// offset: 0xb4
    MACIER: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// PHY Interrupt Enable
        PHYIE: u1,
        /// PMT Interrupt Enable
        PMTIE: u1,
        /// LPI Interrupt Enable
        LPIIE: u1,
        reserved12: u6 = 0,
        /// Timestamp Interrupt Enable
        TSIE: u1,
        /// Transmit Status Interrupt Enable
        TXSTSIE: u1,
        /// Receive Status Interrupt Enable
        RXSTSIE: u1,
        padding: u17 = 0,
    }),
    /// Rx Tx status register
    /// offset: 0xb8
    MACRxTxSR: mmio.Mmio(packed struct(u32) {
        /// Transmit Jabber Timeout
        TJT: u1,
        /// No Carrier
        NCARR: u1,
        /// Loss of Carrier
        LCARR: u1,
        /// Excessive Deferral
        EXDEF: u1,
        /// Late Collision
        LCOL: u1,
        /// Excessive Collisions
        EXCOL: u1,
        reserved8: u2 = 0,
        /// Receive Watchdog Timeout
        RWT: u1,
        padding: u23 = 0,
    }),
    /// offset: 0xbc
    reserved188: [4]u8,
    /// PMT control status register
    /// offset: 0xc0
    MACPCSR: mmio.Mmio(packed struct(u32) {
        /// Power Down
        PWRDWN: u1,
        /// Magic Packet Enable
        MGKPKTEN: u1,
        /// Remote wakeup Packet Enable
        RWKPKTEN: u1,
        reserved5: u2 = 0,
        /// Magic Packet Received
        MGKPRCVD: u1,
        /// Remote wakeup Packet Received
        RWKPRCVD: u1,
        reserved9: u2 = 0,
        /// Global Unicast
        GLBLUCAST: u1,
        /// Remote wakeup Packet Forwarding Enable
        RWKPFE: u1,
        reserved24: u13 = 0,
        /// Remote wakeup FIFO Pointer
        RWKPTR: u5,
        reserved31: u2 = 0,
        /// Remote wakeup Packet Filter Register Pointer Reset
        RWKFILTRST: u1,
    }),
    /// Remove wakeup packet filter register
    /// offset: 0xc4
    MACRWKPFR: mmio.Mmio(packed struct(u32) {
        /// Remote wakeup packet filter
        MACRWKPFR: u32,
    }),
    /// offset: 0xc8
    reserved200: [8]u8,
    /// LPI control status register
    /// offset: 0xd0
    MACLCSR: mmio.Mmio(packed struct(u32) {
        /// Transmit LPI Entry
        TLPIEN: u1,
        /// Transmit LPI Exit
        TLPIEX: u1,
        /// Receive LPI Entry
        RLPIEN: u1,
        /// Receive LPI Exit
        RLPIEX: u1,
        reserved8: u4 = 0,
        /// Transmit LPI State
        TLPIST: u1,
        /// Receive LPI State
        RLPIST: u1,
        reserved16: u6 = 0,
        /// LPI Enable
        LPIEN: u1,
        /// PHY Link Status
        PLS: u1,
        /// PHY Link Status Enable
        PLSEN: u1,
        /// LPI Tx Automate
        LPITXA: u1,
        /// LPI Timer Enable
        LPITE: u1,
        padding: u11 = 0,
    }),
    /// LPI timers control register
    /// offset: 0xd4
    MACLTCR: mmio.Mmio(packed struct(u32) {
        /// LPI TW Timer
        TWT: u16,
        /// LPI LS Timer
        LST: u10,
        padding: u6 = 0,
    }),
    /// LPI entry timer register
    /// offset: 0xd8
    MACLETR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// LPI Entry Timer
        LPIET: u17,
        padding: u12 = 0,
    }),
    /// 1-microsecond-tick counter register
    /// offset: 0xdc
    MAC1USTCR: mmio.Mmio(packed struct(u32) {
        /// 1 µs tick Counter
        TIC_1US_CNTR: u12,
        padding: u20 = 0,
    }),
    /// offset: 0xe0
    reserved224: [48]u8,
    /// Version register
    /// offset: 0x110
    MACVR: mmio.Mmio(packed struct(u32) {
        /// IP version
        SNPSVER: u8,
        /// ST-defined version
        USERVER: u8,
        padding: u16 = 0,
    }),
    /// Debug register
    /// offset: 0x114
    MACDR: mmio.Mmio(packed struct(u32) {
        /// MAC MII Receive Protocol Engine Status
        RPESTS: u1,
        /// MAC Receive Packet Controller FIFO Status
        RFCFCSTS: u2,
        reserved16: u13 = 0,
        /// MAC MII Transmit Protocol Engine Status
        TPESTS: u1,
        /// MAC Transmit Packet Controller Status
        TFCSTS: u2,
        padding: u13 = 0,
    }),
    /// offset: 0x118
    reserved280: [8]u8,
    /// HW feature 1 register
    /// offset: 0x120
    MACHWF1R: mmio.Mmio(packed struct(u32) {
        /// MTL Receive FIFO Size
        RXFIFOSIZE: u5,
        reserved6: u1 = 0,
        /// MTL Transmit FIFO Size
        TXFIFOSIZE: u5,
        /// One-Step Timestamping Enable
        OSTEN: u1,
        /// PTP Offload Enable
        PTOEN: u1,
        /// IEEE 1588 High Word Register Enable
        ADVTHWORD: u1,
        /// Address width
        ADDR64: u2,
        /// DCB Feature Enable
        DCBEN: u1,
        /// Split Header Feature Enable
        SPHEN: u1,
        /// TCP Segmentation Offload Enable
        TSOEN: u1,
        /// DMA Debug Registers Enable
        DBGMEMA: u1,
        /// AV Feature Enable
        AVSEL: u1,
        reserved24: u3 = 0,
        /// Hash Table Size
        HASHTBLSZ: u2,
        reserved27: u1 = 0,
        /// Total number of L3 or L4 Filters
        L3L4FNUM: u4,
        padding: u1 = 0,
    }),
    /// HW feature 2 register
    /// offset: 0x124
    MACHWF2R: mmio.Mmio(packed struct(u32) {
        /// Number of MTL Receive Queues
        RXQCNT: u4,
        reserved6: u2 = 0,
        /// Number of MTL Transmit Queues
        TXQCNT: u4,
        reserved12: u2 = 0,
        /// Number of DMA Receive Channels
        RXCHCNT: u4,
        reserved18: u2 = 0,
        /// Number of DMA Transmit Channels
        TXCHCNT: u4,
        reserved24: u2 = 0,
        /// Number of PPS Outputs
        PPSOUTNUM: u3,
        reserved28: u1 = 0,
        /// Number of Auxiliary Snapshot Inputs
        AUXSNAPNUM: u3,
        padding: u1 = 0,
    }),
    /// offset: 0x128
    reserved296: [216]u8,
    /// MDIO address register
    /// offset: 0x200
    MACMDIOAR: mmio.Mmio(packed struct(u32) {
        /// MII Busy
        MB: u1,
        /// Clause 45 PHY Enable
        C45E: u1,
        /// MII Operation Command
        GOC: u2,
        /// Skip Address Packet
        SKAP: u1,
        reserved8: u3 = 0,
        /// CSR Clock Range
        CR: u4,
        /// Number of Training Clocks
        NTC: u3,
        reserved16: u1 = 0,
        /// Register/Device Address
        RDA: u5,
        /// Physical Layer Address
        PA: u5,
        /// Back to Back transactions
        BTB: u1,
        /// Preamble Suppression Enable
        PSE: u1,
        padding: u4 = 0,
    }),
    /// MDIO data register
    /// offset: 0x204
    MACMDIODR: mmio.Mmio(packed struct(u32) {
        /// MII Data
        MD: u16,
        /// Register Address
        RA: u16,
    }),
    /// offset: 0x208
    reserved520: [248]u8,
    /// Address 0 high register
    /// offset: 0x300
    MACA0HR: mmio.Mmio(packed struct(u32) {
        /// MAC Address0[47:32]
        ADDRHI: u16,
        reserved31: u15 = 0,
        /// Address Enable
        AE: u1,
    }),
    /// Address 0 low register
    /// offset: 0x304
    MACA0LR: mmio.Mmio(packed struct(u32) {
        /// MAC Address 0 [31:0]
        ADDRLO: u32,
    }),
    /// Address 1/2/3 high register
    /// offset: 0x308
    MACAHR: mmio.Mmio(packed struct(u32) {
        /// MAC Address 1/2/3 [47:32]
        ADDRHI: u16,
        reserved24: u8 = 0,
        /// Mask Byte Control
        MBC: u6,
        /// Source Address
        SA: u1,
        /// Address Enable
        AE: u1,
    }),
    /// Address 1/2/3 low register
    /// offset: 0x30c
    MACALR: mmio.Mmio(packed struct(u32) {
        /// MAC Address 1/2/3 [31:0]
        ADDRLO: u32,
    }),
    /// offset: 0x310
    reserved784: [1008]u8,
    /// MMC control register
    /// offset: 0x700
    MMC_CONTROL: mmio.Mmio(packed struct(u32) {
        /// Counters Reset
        CNTRST: u1,
        /// Counter Stop Rollover
        CNTSTOPRO: u1,
        /// Reset on Read
        RSTONRD: u1,
        /// MMC Counter Freeze
        CNTFREEZ: u1,
        /// Counters Preset
        CNTPRST: u1,
        /// Full-Half Preset
        CNTPRSTLVL: u1,
        reserved8: u2 = 0,
        /// Update MMC Counters for Dropped Broadcast Packets
        UCDBC: u1,
        padding: u23 = 0,
    }),
    /// MMC Rx interrupt register
    /// offset: 0x704
    MMC_RX_INTERRUPT: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// MMC Receive CRC Error Packet Counter Interrupt Status
        RXCRCERPIS: u1,
        /// MMC Receive Alignment Error Packet Counter Interrupt Status
        RXALGNERPIS: u1,
        reserved17: u10 = 0,
        /// MMC Receive Unicast Good Packet Counter Interrupt Status
        RXUCGPIS: u1,
        reserved26: u8 = 0,
        /// MMC Receive LPI microsecond counter interrupt status
        RXLPIUSCIS: u1,
        /// MMC Receive LPI transition counter interrupt status
        RXLPITRCIS: u1,
        padding: u4 = 0,
    }),
    /// MMC Tx interrupt register
    /// offset: 0x708
    MMC_TX_INTERRUPT: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// MMC Transmit Single Collision Good Packet Counter Interrupt Status
        TXSCOLGPIS: u1,
        /// MMC Transmit Multiple Collision Good Packet Counter Interrupt Status
        TXMCOLGPIS: u1,
        reserved21: u5 = 0,
        /// MMC Transmit Good Packet Counter Interrupt Status
        TXGPKTIS: u1,
        reserved26: u4 = 0,
        /// MMC Transmit LPI microsecond counter interrupt status
        TXLPIUSCIS: u1,
        /// MMC Transmit LPI transition counter interrupt status
        TXLPITRCIS: u1,
        padding: u4 = 0,
    }),
    /// MMC Rx interrupt mask register
    /// offset: 0x70c
    MMC_RX_INTERRUPT_MASK: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// MMC Receive CRC Error Packet Counter Interrupt Mask
        RXCRCERPIM: u1,
        /// MMC Receive Alignment Error Packet Counter Interrupt Mask
        RXALGNERPIM: u1,
        reserved17: u10 = 0,
        /// MMC Receive Unicast Good Packet Counter Interrupt Mask
        RXUCGPIM: u1,
        reserved26: u8 = 0,
        /// MMC Receive LPI microsecond counter interrupt Mask
        RXLPIUSCIM: u1,
        /// MMC Receive LPI transition counter interrupt Mask
        RXLPITRCIM: u1,
        padding: u4 = 0,
    }),
    /// MMC Tx interrupt mask register
    /// offset: 0x710
    MMC_TX_INTERRUPT_MASK: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// MMC Transmit Single Collision Good Packet Counter Interrupt Mask
        TXSCOLGPIM: u1,
        /// MMC Transmit Multiple Collision Good Packet Counter Interrupt Mask
        TXMCOLGPIM: u1,
        reserved21: u5 = 0,
        /// MMC Transmit Good Packet Counter Interrupt Mask
        TXGPKTIM: u1,
        reserved26: u4 = 0,
        /// MMC Transmit LPI microsecond counter interrupt Mask
        TXLPIUSCIM: u1,
        /// MMC Transmit LPI transition counter interrupt Mask
        TXLPITRCIM: u1,
        padding: u4 = 0,
    }),
    /// offset: 0x714
    reserved1812: [56]u8,
    /// Tx single collision good packets register
    /// offset: 0x74c
    TX_SINGLE_COLLISION_GOOD_PACKETS: mmio.Mmio(packed struct(u32) {
        /// Tx Single Collision Good Packets
        TXSNGLCOLG: u32,
    }),
    /// Tx multiple collision good packets register
    /// offset: 0x750
    TX_MULTIPLE_COLLISION_GOOD_PACKETS: mmio.Mmio(packed struct(u32) {
        /// Tx Multiple Collision Good Packets
        TXMULTCOLG: u32,
    }),
    /// offset: 0x754
    reserved1876: [20]u8,
    /// Tx packet count good register
    /// offset: 0x768
    TX_PACKET_COUNT_GOOD: mmio.Mmio(packed struct(u32) {
        /// Tx Packet Count Good
        TXPKTG: u32,
    }),
    /// offset: 0x76c
    reserved1900: [40]u8,
    /// Rx CRC error packets register
    /// offset: 0x794
    RX_CRC_ERROR_PACKETS: mmio.Mmio(packed struct(u32) {
        /// Rx CRC Error Packets
        RXCRCERR: u32,
    }),
    /// Rx alignment error packets register
    /// offset: 0x798
    RX_ALIGNMENT_ERROR_PACKETS: mmio.Mmio(packed struct(u32) {
        /// Rx Alignment Error Packets
        RXALGNERR: u32,
    }),
    /// offset: 0x79c
    reserved1948: [40]u8,
    /// Rx unicast packets good register
    /// offset: 0x7c4
    RX_UNICAST_PACKETS_GOOD: mmio.Mmio(packed struct(u32) {
        /// Rx Unicast Packets Good
        RXUCASTG: u32,
    }),
    /// offset: 0x7c8
    reserved1992: [36]u8,
    /// Tx LPI microsecond timer register
    /// offset: 0x7ec
    TX_LPI_USEC_CNTR: mmio.Mmio(packed struct(u32) {
        /// Tx LPI Microseconds Counter
        TXLPIUSC: u32,
    }),
    /// Tx LPI transition counter register
    /// offset: 0x7f0
    TX_LPI_TRAN_CNTR: mmio.Mmio(packed struct(u32) {
        /// Tx LPI Transition counter
        TXLPITRC: u32,
    }),
    /// Rx LPI microsecond counter register
    /// offset: 0x7f4
    RX_LPI_USEC_CNTR: mmio.Mmio(packed struct(u32) {
        /// Rx LPI Microseconds Counter
        RXLPIUSC: u32,
    }),
    /// Rx LPI transition counter register
    /// offset: 0x7f8
    RX_LPI_TRAN_CNTR: mmio.Mmio(packed struct(u32) {
        /// Rx LPI Transition counter
        RXLPITRC: u32,
    }),
    /// offset: 0x7fc
    reserved2044: [260]u8,
    /// L3 and L4 control 0 register
    /// offset: 0x900
    MACL3L4C0R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Protocol Enable
        L3PEN0: u1,
        reserved2: u1 = 0,
        /// Layer 3 IP SA Match Enable
        L3SAM0: u1,
        /// Layer 3 IP SA Inverse Match Enable
        L3SAIM0: u1,
        /// Layer 3 IP DA Match Enable
        L3DAM0: u1,
        /// Layer 3 IP DA Inverse Match Enable
        L3DAIM0: u1,
        /// Layer 3 IP SA Higher Bits Match
        L3HSBM0: u5,
        /// Layer 3 IP DA Higher Bits Match
        L3HDBM0: u5,
        /// Layer 4 Protocol Enable
        L4PEN0: u1,
        reserved18: u1 = 0,
        /// Layer 4 Source Port Match Enable
        L4SPM0: u1,
        /// Layer 4 Source Port Inverse Match Enable
        L4SPIM0: u1,
        /// Layer 4 Destination Port Match Enable
        L4DPM0: u1,
        /// Layer 4 Destination Port Inverse Match Enable
        L4DPIM0: u1,
        padding: u10 = 0,
    }),
    /// Layer4 address filter 0 register
    /// offset: 0x904
    MACL4A0R: mmio.Mmio(packed struct(u32) {
        /// Layer 4 Source Port Number Field
        L4SP0: u16,
        /// Layer 4 Destination Port Number Field
        L4DP0: u16,
    }),
    /// offset: 0x908
    reserved2312: [8]u8,
    /// MACL3A00R
    /// offset: 0x910
    MACL3A00R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 0 Field
        L3A00: u32,
    }),
    /// Layer3 address 1 filter 0 register
    /// offset: 0x914
    MACL3A10R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 1 Field
        L3A10: u32,
    }),
    /// Layer3 Address 2 filter 0 register
    /// offset: 0x918
    MACL3A20: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 2 Field
        L3A20: u32,
    }),
    /// Layer3 Address 3 filter 0 register
    /// offset: 0x91c
    MACL3A30: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 3 Field
        L3A30: u32,
    }),
    /// offset: 0x920
    reserved2336: [16]u8,
    /// L3 and L4 control 1 register
    /// offset: 0x930
    MACL3L4C1R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Protocol Enable
        L3PEN1: u1,
        reserved2: u1 = 0,
        /// Layer 3 IP SA Match Enable
        L3SAM1: u1,
        /// Layer 3 IP SA Inverse Match Enable
        L3SAIM1: u1,
        /// Layer 3 IP DA Match Enable
        L3DAM1: u1,
        /// Layer 3 IP DA Inverse Match Enable
        L3DAIM1: u1,
        /// Layer 3 IP SA Higher Bits Match
        L3HSBM1: u5,
        /// Layer 3 IP DA Higher Bits Match
        L3HDBM1: u5,
        /// Layer 4 Protocol Enable
        L4PEN1: u1,
        reserved18: u1 = 0,
        /// Layer 4 Source Port Match Enable
        L4SPM1: u1,
        /// Layer 4 Source Port Inverse Match Enable
        L4SPIM1: u1,
        /// Layer 4 Destination Port Match Enable
        L4DPM1: u1,
        /// Layer 4 Destination Port Inverse Match Enable
        L4DPIM1: u1,
        padding: u10 = 0,
    }),
    /// Layer 4 address filter 1 register
    /// offset: 0x934
    MACL4A1R: mmio.Mmio(packed struct(u32) {
        /// Layer 4 Source Port Number Field
        L4SP1: u16,
        /// Layer 4 Destination Port Number Field
        L4DP1: u16,
    }),
    /// offset: 0x938
    reserved2360: [8]u8,
    /// Layer3 address 0 filter 1 Register
    /// offset: 0x940
    MACL3A01R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 0 Field
        L3A01: u32,
    }),
    /// Layer3 address 1 filter 1 register
    /// offset: 0x944
    MACL3A11R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 1 Field
        L3A11: u32,
    }),
    /// Layer3 address 2 filter 1 Register
    /// offset: 0x948
    MACL3A21R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 2 Field
        L3A21: u32,
    }),
    /// Layer3 address 3 filter 1 register
    /// offset: 0x94c
    MACL3A31R: mmio.Mmio(packed struct(u32) {
        /// Layer 3 Address 3 Field
        L3A31: u32,
    }),
    /// offset: 0x950
    reserved2384: [400]u8,
    /// ARP address register
    /// offset: 0xae0
    MACARPAR: mmio.Mmio(packed struct(u32) {
        /// ARP Protocol Address
        ARPPA: u32,
    }),
    /// offset: 0xae4
    reserved2788: [28]u8,
    /// Timestamp control Register
    /// offset: 0xb00
    MACTSCR: mmio.Mmio(packed struct(u32) {
        /// Enable Timestamp
        TSENA: u1,
        /// Fine or Coarse Timestamp Update
        TSCFUPDT: u1,
        /// Initialize Timestamp
        TSINIT: u1,
        /// Update Timestamp
        TSUPDT: u1,
        reserved5: u1 = 0,
        /// Update Addend Register
        TSADDREG: u1,
        reserved8: u2 = 0,
        /// Enable Timestamp for All Packets
        TSENALL: u1,
        /// Timestamp Digital or Binary Rollover Control
        TSCTRLSSR: u1,
        /// Enable PTP Packet Processing for Version 2 Format
        TSVER2ENA: u1,
        /// Enable Processing of PTP over Ethernet Packets
        TSIPENA: u1,
        /// Enable Processing of PTP Packets Sent over IPv6-UDP
        TSIPV6ENA: u1,
        /// Enable Processing of PTP Packets Sent over IPv4-UDP
        TSIPV4ENA: u1,
        /// Enable Timestamp Snapshot for Event Messages
        TSEVNTENA: u1,
        /// Enable Snapshot for Messages Relevant to Master
        TSMSTRENA: u1,
        /// Select PTP packets for Taking Snapshots
        SNAPTYPSEL: u2,
        /// Enable MAC Address for PTP Packet Filtering
        TSENMACADDR: u1,
        /// Enable checksum correction during OST for PTP over UDP/IPv4 packets
        CSC: u1,
        reserved24: u4 = 0,
        /// Transmit Timestamp Status Mode
        TXTSSTSM: u1,
        padding: u7 = 0,
    }),
    /// Sub-second increment register
    /// offset: 0xb04
    MACSSIR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// Sub-nanosecond Increment Value
        SNSINC: u8,
        /// Sub-second Increment Value
        SSINC: u8,
        padding: u8 = 0,
    }),
    /// System time seconds register
    /// offset: 0xb08
    MACSTSR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Second
        TSS: u32,
    }),
    /// System time nanoseconds register
    /// offset: 0xb0c
    MACSTNR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Sub-seconds
        TSSS: u31,
        padding: u1 = 0,
    }),
    /// System time seconds update register
    /// offset: 0xb10
    MACSTSUR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Seconds
        TSS: u32,
    }),
    /// System time nanoseconds update register
    /// offset: 0xb14
    MACSTNUR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Sub-seconds
        TSSS: u31,
        /// Add or Subtract Time
        ADDSUB: u1,
    }),
    /// Timestamp addend register
    /// offset: 0xb18
    MACTSAR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Addend Register
        TSAR: u32,
    }),
    /// offset: 0xb1c
    reserved2844: [4]u8,
    /// Timestamp status register
    /// offset: 0xb20
    MACTSSR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Seconds Overflow
        TSSOVF: u1,
        /// Timestamp Target Time Reached
        TSTARGT0: u1,
        /// Auxiliary Timestamp Trigger Snapshot
        AUXTSTRIG: u1,
        /// Timestamp Target Time Error
        TSTRGTERR0: u1,
        reserved15: u11 = 0,
        /// Tx Timestamp Status Interrupt Status
        TXTSSIS: u1,
        /// Auxiliary Timestamp Snapshot Trigger Identifier
        ATSSTN: u4,
        reserved24: u4 = 0,
        /// Auxiliary Timestamp Snapshot Trigger Missed
        ATSSTM: u1,
        /// Number of Auxiliary Timestamp Snapshots
        ATSNS: u5,
        padding: u2 = 0,
    }),
    /// offset: 0xb24
    reserved2852: [12]u8,
    /// Tx timestamp status nanoseconds register
    /// offset: 0xb30
    MACTxTSSNR: mmio.Mmio(packed struct(u32) {
        /// Transmit Timestamp Status Low
        TXTSSLO: u31,
        /// Transmit Timestamp Status Missed
        TXTSSMIS: u1,
    }),
    /// Tx timestamp status seconds register
    /// offset: 0xb34
    MACTxTSSSR: mmio.Mmio(packed struct(u32) {
        /// Transmit Timestamp Status High
        TXTSSHI: u32,
    }),
    /// offset: 0xb38
    reserved2872: [8]u8,
    /// Auxiliary control register
    /// offset: 0xb40
    MACACR: mmio.Mmio(packed struct(u32) {
        /// Auxiliary Snapshot FIFO Clear
        ATSFC: u1,
        reserved4: u3 = 0,
        /// (1/4 of ATSEN) Auxiliary Snapshot 0-3 Enable
        @"ATSEN[0]": u1,
        /// (2/4 of ATSEN) Auxiliary Snapshot 0-3 Enable
        @"ATSEN[1]": u1,
        /// (3/4 of ATSEN) Auxiliary Snapshot 0-3 Enable
        @"ATSEN[2]": u1,
        /// (4/4 of ATSEN) Auxiliary Snapshot 0-3 Enable
        @"ATSEN[3]": u1,
        padding: u24 = 0,
    }),
    /// offset: 0xb44
    reserved2884: [4]u8,
    /// Auxiliary timestamp nanoseconds register
    /// offset: 0xb48
    MACATSNR: mmio.Mmio(packed struct(u32) {
        /// Auxiliary Timestamp
        AUXTSLO: u31,
        padding: u1 = 0,
    }),
    /// Auxiliary timestamp seconds register
    /// offset: 0xb4c
    MACATSSR: mmio.Mmio(packed struct(u32) {
        /// Auxiliary Timestamp
        AUXTSHI: u32,
    }),
    /// Timestamp Ingress asymmetric correction register
    /// offset: 0xb50
    MACTSIACR: mmio.Mmio(packed struct(u32) {
        /// One-Step Timestamp Ingress Asymmetry Correction
        OSTIAC: u32,
    }),
    /// Timestamp Egress asymmetric correction register
    /// offset: 0xb54
    MACTSEACR: mmio.Mmio(packed struct(u32) {
        /// One-Step Timestamp Egress Asymmetry Correction
        OSTEAC: u32,
    }),
    /// Timestamp Ingress correction nanosecond register
    /// offset: 0xb58
    MACTSICNR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Ingress Correction
        TSIC: u32,
    }),
    /// Timestamp Egress correction nanosecond register
    /// offset: 0xb5c
    MACTSECNR: mmio.Mmio(packed struct(u32) {
        /// Timestamp Egress Correction
        TSEC: u32,
    }),
    /// offset: 0xb60
    reserved2912: [16]u8,
    /// PPS control register
    /// offset: 0xb70
    MACPPSCR: mmio.Mmio(packed struct(u32) {
        /// Flexible PPS Output (ptp_pps_o[0]) Control or PPSCTRL PPS Output Frequency Control if PPSEN0 is cleared
        PPSCTRL: u4,
        /// Flexible PPS Output Mode Enable
        PPSEN0: u1,
        /// Target Time Register Mode for PPS Output
        TRGTMODSEL0: u2,
        padding: u25 = 0,
    }),
    /// offset: 0xb74
    reserved2932: [12]u8,
    /// PPS target time seconds register
    /// offset: 0xb80
    MACPPSTTSR: mmio.Mmio(packed struct(u32) {
        /// PPS Target Time Seconds Register
        TSTRH0: u31,
        padding: u1 = 0,
    }),
    /// PPS target time nanoseconds register
    /// offset: 0xb84
    MACPPSTTNR: mmio.Mmio(packed struct(u32) {
        /// Target Time Low for PPS Register
        TTSL0: u31,
        /// PPS Target Time Register Busy
        TRGTBUSY0: u1,
    }),
    /// PPS interval register
    /// offset: 0xb88
    MACPPSIR: mmio.Mmio(packed struct(u32) {
        /// PPS Output Signal Interval
        PPSINT0: u32,
    }),
    /// PPS width register
    /// offset: 0xb8c
    MACPPSWR: mmio.Mmio(packed struct(u32) {
        /// PPS Output Signal Width
        PPSWIDTH0: u32,
    }),
    /// offset: 0xb90
    reserved2960: [48]u8,
    /// PTP Offload control register
    /// offset: 0xbc0
    MACPOCR: mmio.Mmio(packed struct(u32) {
        /// PTP Offload Enable
        PTOEN: u1,
        /// Automatic PTP SYNC message Enable
        ASYNCEN: u1,
        /// Automatic PTP Pdelay_Req message Enable
        APDREQEN: u1,
        reserved4: u1 = 0,
        /// Automatic PTP SYNC message Trigger
        ASYNCTRIG: u1,
        /// Automatic PTP Pdelay_Req message Trigger
        APDREQTRIG: u1,
        /// Disable PTO Delay Request/Response response generation
        DRRDIS: u1,
        reserved8: u1 = 0,
        /// Domain Number
        DN: u8,
        padding: u16 = 0,
    }),
    /// PTP Source Port Identity 0 Register
    /// offset: 0xbc4
    MACSPI0R: mmio.Mmio(packed struct(u32) {
        /// Source Port Identity 0
        SPI0: u32,
    }),
    /// PTP Source port identity 1 register
    /// offset: 0xbc8
    MACSPI1R: mmio.Mmio(packed struct(u32) {
        /// Source Port Identity 1
        SPI1: u32,
    }),
    /// PTP Source port identity 2 register
    /// offset: 0xbcc
    MACSPI2R: mmio.Mmio(packed struct(u32) {
        /// Source Port Identity 2
        SPI2: u16,
        padding: u16 = 0,
    }),
    /// Log message interval register
    /// offset: 0xbd0
    MACLMIR: mmio.Mmio(packed struct(u32) {
        /// Log Sync Interval
        LSI: u8,
        /// Delay_Req to SYNC Ratio
        DRSYNCR: u3,
        reserved24: u13 = 0,
        /// Log Min Pdelay_Req Interval
        LMPDRI: u8,
    }),
};

/// Ethernet: MTL mode register (MTL)
pub const ETHERNET_MTL = extern struct {
    /// Operating mode Register
    /// offset: 0x00
    MTLOMR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Drop Transmit Status
        DTXSTS: u1,
        reserved8: u6 = 0,
        /// Counters Preset
        CNTPRST: u1,
        /// Counters Reset
        CNTCLR: u1,
        padding: u22 = 0,
    }),
    /// offset: 0x04
    reserved4: [28]u8,
    /// Interrupt status Register
    /// offset: 0x20
    MTLISR: mmio.Mmio(packed struct(u32) {
        /// Queue interrupt status
        Q0IS: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x24
    reserved36: [220]u8,
    /// Tx queue operating mode Register
    /// offset: 0x100
    MTLTxQOMR: mmio.Mmio(packed struct(u32) {
        /// Flush Transmit Queue
        FTQ: u1,
        /// Transmit Store and Forward
        TSF: u1,
        /// Transmit Queue Enable
        TXQEN: u2,
        /// Transmit Threshold Control
        TTC: u3,
        reserved16: u9 = 0,
        /// Transmit Queue Size
        TQS: u3,
        padding: u13 = 0,
    }),
    /// Tx queue underflow register
    /// offset: 0x104
    MTLTxQUR: mmio.Mmio(packed struct(u32) {
        /// Underflow Packet Counter
        UFFRMCNT: u11,
        /// Overflow Bit for Underflow Packet Counter
        UFCNTOVF: u1,
        padding: u20 = 0,
    }),
    /// Tx queue debug Register
    /// offset: 0x108
    MTLTxQDR: mmio.Mmio(packed struct(u32) {
        /// Transmit Queue in Pause
        TXQPAUSED: u1,
        /// MTL Tx Queue Read Controller Status
        TRCSTS: u2,
        /// MTL Tx Queue Write Controller Status
        TWCSTS: u1,
        /// MTL Tx Queue Not Empty Status
        TXQSTS: u1,
        /// MTL Tx Status FIFO Full Status
        TXSTSFSTS: u1,
        reserved16: u10 = 0,
        /// Number of Packets in the Transmit Queue
        PTXQ: u3,
        reserved20: u1 = 0,
        /// Number of Status Words in Tx Status FIFO of Queue
        STXSTSF: u3,
        padding: u9 = 0,
    }),
    /// offset: 0x10c
    reserved268: [32]u8,
    /// Queue interrupt control status Register
    /// offset: 0x12c
    MTLQICSR: mmio.Mmio(packed struct(u32) {
        /// Transmit Queue Underflow Interrupt Status
        TXUNFIS: u1,
        reserved8: u7 = 0,
        /// Transmit Queue Underflow Interrupt Enable
        TXUIE: u1,
        reserved16: u7 = 0,
        /// Receive Queue Overflow Interrupt Status
        RXOVFIS: u1,
        reserved24: u7 = 0,
        /// Receive Queue Overflow Interrupt Enable
        RXOIE: u1,
        padding: u7 = 0,
    }),
    /// Rx queue operating mode register
    /// offset: 0x130
    MTLRxQOMR: mmio.Mmio(packed struct(u32) {
        /// Receive Queue Threshold Control
        RTC: u2,
        reserved3: u1 = 0,
        /// Forward Undersized Good Packets
        FUP: u1,
        /// Forward Error Packets
        FEP: u1,
        /// Receive Queue Store and Forward
        RSF: u1,
        /// Disable Dropping of TCP/IP Checksum Error Packets
        DIS_TCP_EF: u1,
        /// Enable Hardware Flow Control
        EHFC: u1,
        /// Threshold for Activating Flow Control (in half-duplex and full-duplex modes)
        RFA: u3,
        reserved14: u3 = 0,
        /// Threshold for Deactivating Flow Control (in half-duplex and full-duplex modes)
        RFD: u3,
        reserved20: u3 = 0,
        /// Receive Queue Size
        RQS: u3,
        padding: u9 = 0,
    }),
    /// Rx queue missed packet and overflow counter register
    /// offset: 0x134
    MTLRxQMPOCR: mmio.Mmio(packed struct(u32) {
        /// Overflow Packet Counter
        OVFPKTCNT: u11,
        /// Overflow Counter Overflow Bit
        OVFCNTOVF: u1,
        reserved16: u4 = 0,
        /// Missed Packet Counter
        MISPKTCNT: u11,
        /// Missed Packet Counter Overflow Bit
        MISCNTOVF: u1,
        padding: u4 = 0,
    }),
    /// Rx queue debug register
    /// offset: 0x138
    MTLRxQDR: mmio.Mmio(packed struct(u32) {
        /// MTL Rx Queue Write Controller Active Status
        RWCSTS: u1,
        /// MTL Rx Queue Read Controller State
        RRCSTS: u2,
        reserved4: u1 = 0,
        /// MTL Rx Queue Fill-Level Status
        RXQSTS: u2,
        reserved16: u10 = 0,
        /// Number of Packets in Receive Queue
        PRXQ: u14,
        padding: u2 = 0,
    }),
};
