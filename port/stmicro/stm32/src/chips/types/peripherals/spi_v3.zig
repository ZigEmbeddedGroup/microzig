const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const CHLEN = enum(u1) {
    /// 16 bits per channel
    Bits16 = 0x0,
    /// 32 bits per channel
    Bits32 = 0x1,
};

pub const CKPOL = enum(u1) {
    /// CK idle Level is Low. Signals are sampled on rising and changed on falling clock edges
    IdleLow = 0x0,
    /// CK idle level is High. Signals are sampled on falling and changed on rising clock edges
    IdleHigh = 0x1,
};

pub const COMM = enum(u2) {
    /// Full duplex
    FullDuplex = 0x0,
    /// Simplex transmitter only
    Transmitter = 0x1,
    /// Simplex receiver only
    Receiver = 0x2,
    /// Half duplex
    HalfDuplex = 0x3,
};

pub const CPHA = enum(u1) {
    /// The first clock transition is the first data capture edge
    FirstEdge = 0x0,
    /// The second clock transition is the first data capture edge
    SecondEdge = 0x1,
};

pub const CPOL = enum(u1) {
    /// SCK to 0 when idle
    IdleLow = 0x0,
    /// SCK to 1 when idle
    IdleHigh = 0x1,
};

pub const DATFMT = enum(u1) {
    /// The data inside RXDR and TXDR are right aligned
    RightAligned = 0x0,
    /// The data inside RXDR and TXDR are left aligned
    LeftAligned = 0x1,
};

pub const DATLEN = enum(u2) {
    /// 16-bit data length
    Bits16 = 0x0,
    /// 24-bit data length
    Bits24 = 0x1,
    /// 32-bit data length
    Bits32 = 0x2,
    _,
};

pub const FIXCH = enum(u1) {
    /// The channel length in slave mode is different from 16 or 32 bits (CHLEN not taken into account)
    NotFixed = 0x0,
    /// The channel length in slave mode is supposed to be 16 or 32 bits (according to CHLEN)
    Fixed = 0x1,
};

pub const FTHLV = enum(u4) {
    /// 1 frame
    OneFrame = 0x0,
    /// 2 frames
    TwoFrames = 0x1,
    /// 3 frames
    ThreeFrames = 0x2,
    /// 4 frames
    FourFrames = 0x3,
    /// 5 frames
    FiveFrames = 0x4,
    /// 6 frames
    SixFrames = 0x5,
    /// 7 frames
    SevenFrames = 0x6,
    /// 8 frames
    EightFrames = 0x7,
    /// 9 frames
    NineFrames = 0x8,
    /// 10 frames
    TenFrames = 0x9,
    /// 11 frames
    ElevenFrames = 0xa,
    /// 12 frames
    TwelveFrames = 0xb,
    /// 13 frames
    ThirteenFrames = 0xc,
    /// 14 frames
    FourteenFrames = 0xd,
    /// 15 frames
    FifteenFrames = 0xe,
    /// 16 frames
    SixteenFrames = 0xf,
};

pub const HDDIR = enum(u1) {
    /// Receiver in half duplex mode
    Receiver = 0x0,
    /// Transmitter in half duplex mode
    Transmitter = 0x1,
};

pub const I2SCFG = enum(u3) {
    /// Slave, transmit
    SlaveTx = 0x0,
    /// Slave, receive
    SlaveRx = 0x1,
    /// Master, transmit
    MasterTx = 0x2,
    /// Master, receive
    MasterRx = 0x3,
    /// Slave, full duplex
    SlaveFullDuplex = 0x4,
    /// Master, full duplex
    MasterFullDuplex = 0x5,
    _,
};

pub const I2SSTD = enum(u2) {
    /// I2S Philips standard
    Philips = 0x0,
    /// MSB/left justified standard
    MSB = 0x1,
    /// LSB/right justified standard
    LSB = 0x2,
    /// PCM standard
    PCM = 0x3,
};

pub const LSBFIRST = enum(u1) {
    /// Data is transmitted/received with the MSB first
    MSBFirst = 0x0,
    /// Data is transmitted/received with the LSB first
    LSBFirst = 0x1,
};

pub const MASTER = enum(u1) {
    /// Slave configuration
    Slave = 0x0,
    /// Master configuration
    Master = 0x1,
};

pub const MBR = enum(u3) {
    /// f_spi_ker_ck / 2
    Div2 = 0x0,
    /// f_spi_ker_ck / 4
    Div4 = 0x1,
    /// f_spi_ker_ck / 8
    Div8 = 0x2,
    /// f_spi_ker_ck / 16
    Div16 = 0x3,
    /// f_spi_ker_ck / 32
    Div32 = 0x4,
    /// f_spi_ker_ck / 64
    Div64 = 0x5,
    /// f_spi_ker_ck / 128
    Div128 = 0x6,
    /// f_spi_ker_ck / 256
    Div256 = 0x7,
};

pub const ODD = enum(u1) {
    /// Real divider value is I2SDIV*2
    Even = 0x0,
    /// Real divider value is I2SDIV*2 + 1
    Odd = 0x1,
};

pub const PCMSYNC = enum(u1) {
    /// Short PCM frame synchronization
    Short = 0x0,
    /// Long PCM frame synchronization
    Long = 0x1,
};

pub const RCRCINI = enum(u1) {
    /// All zeros RX CRC initialization pattern
    AllZeros = 0x0,
    /// All ones RX CRC initialization pattern
    AllOnes = 0x1,
};

pub const RXPLVL = enum(u2) {
    /// Zero frames beyond packing ratio available
    ZeroFrames = 0x0,
    /// One frame beyond packing ratio available
    OneFrame = 0x1,
    /// Two frame beyond packing ratio available
    TwoFrames = 0x2,
    /// Three frame beyond packing ratio available
    ThreeFrames = 0x3,
};

pub const RXWNE = enum(u1) {
    /// Less than 32-bit data frame received
    LessThan32 = 0x0,
    /// At least 32-bit data frame received
    AtLeast32 = 0x1,
};

pub const SP = enum(u3) {
    /// Motorola SPI protocol
    Motorola = 0x0,
    /// TI SPI protocol
    TI = 0x1,
    _,
};

pub const SSIOP = enum(u1) {
    /// Low level is active for SS signal
    ActiveLow = 0x0,
    /// High level is active for SS signal
    ActiveHigh = 0x1,
};

pub const SSOM = enum(u1) {
    /// SS is asserted until data transfer complete
    Asserted = 0x0,
    /// Data frames interleaved with SS not asserted during MIDI
    NotAsserted = 0x1,
};

pub const TCRCINI = enum(u1) {
    /// All zeros TX CRC initialization pattern
    AllZeros = 0x0,
    /// All ones TX CRC initialization pattern
    AllOnes = 0x1,
};

pub const UDRCFG = enum(u2) {
    /// Slave sends a constant underrun pattern
    Constant = 0x0,
    /// Slave repeats last received data frame from master
    RepeatReceived = 0x1,
    /// Slave repeats last transmitted data frame
    RepeatTransmitted = 0x2,
    _,
};

pub const UDRDET = enum(u2) {
    /// Underrun is detected at begin of data frame
    StartOfFrame = 0x0,
    /// Underrun is detected at end of last data frame
    EndOfFrame = 0x1,
    /// Underrun is detected at begin of active SS signal
    StartOfSlaveSelect = 0x2,
    _,
};

/// Serial peripheral interface
pub const SPI = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Serial Peripheral Enable
        SPE: u1,
        reserved8: u7 = 0,
        /// Master automatic SUSP in Receive mode
        MASRX: u1,
        /// Master transfer start
        CSTART: u1,
        /// Master SUSPend request
        CSUSP: u1,
        /// Rx/Tx direction at Half-duplex mode
        HDDIR: HDDIR,
        /// Internal SS signal input level
        SSI: u1,
        /// Full size (33-bit or 17-bit) CRC polynomial is used
        CRC33_17: u1,
        /// CRC calculation initialization pattern control for receiver
        RCRCINI: RCRCINI,
        /// CRC calculation initialization pattern control for transmitter
        TCRCINI: TCRCINI,
        /// Locking the AF configuration of associated IOs
        IOLOCK: u1,
        padding: u15 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Number of data at current transfer
        TSIZE: u16,
        /// Number of data transfer extension to be reload into TSIZE just when a previous
        TSER: u16,
    }),
    /// configuration register 1
    /// offset: 0x08
    CFG1: mmio.Mmio(packed struct(u32) {
        /// Number of bits in at single SPI data frame
        DSIZE: u5,
        /// threshold level
        FTHLV: FTHLV,
        /// Behavior of slave transmitter at underrun condition
        UDRCFG: UDRCFG,
        /// Detection of underrun condition at slave transmitter
        UDRDET: UDRDET,
        reserved14: u1 = 0,
        /// Rx DMA stream enable
        RXDMAEN: u1,
        /// Tx DMA stream enable
        TXDMAEN: u1,
        /// Length of CRC frame to be transacted and compared
        CRCSIZE: u5,
        reserved22: u1 = 0,
        /// Hardware CRC computation enable
        CRCEN: u1,
        reserved28: u5 = 0,
        /// Master baud rate
        MBR: MBR,
        padding: u1 = 0,
    }),
    /// configuration register 2
    /// offset: 0x0c
    CFG2: mmio.Mmio(packed struct(u32) {
        /// Master SS Idleness
        MSSI: u4,
        /// Master Inter-Data Idleness
        MIDI: u4,
        reserved15: u7 = 0,
        /// Swap functionality of MISO and MOSI pins
        IOSWP: u1,
        reserved17: u1 = 0,
        /// SPI Communication Mode
        COMM: COMM,
        /// Serial Protocol
        SP: SP,
        /// SPI Master
        MASTER: MASTER,
        /// Data frame format
        LSBFIRST: LSBFIRST,
        /// Clock phase
        CPHA: CPHA,
        /// Clock polarity
        CPOL: CPOL,
        /// Software management of SS signal input
        SSM: u1,
        reserved28: u1 = 0,
        /// SS input/output polarity
        SSIOP: SSIOP,
        /// SS output enable
        SSOE: u1,
        /// SS output management in master mode
        SSOM: SSOM,
        /// Alternate function always control GPIOs
        AFCNTR: u1,
    }),
    /// Interrupt Enable Register
    /// offset: 0x10
    IER: mmio.Mmio(packed struct(u32) {
        /// RXP Interrupt Enable
        RXPIE: u1,
        /// TXP interrupt enable
        TXPIE: u1,
        /// DXP interrupt enabled
        DXPIE: u1,
        /// EOT, SUSP and TXC interrupt enable
        EOTIE: u1,
        /// TXTFIE interrupt enable
        TXTFIE: u1,
        /// UDR interrupt enable
        UDRIE: u1,
        /// OVR interrupt enable
        OVRIE: u1,
        /// CRC Interrupt enable
        CRCEIE: u1,
        /// TIFRE interrupt enable
        TIFREIE: u1,
        /// Mode Fault interrupt enable
        MODFIE: u1,
        /// Additional number of transactions reload interrupt enable
        TSERFIE: u1,
        padding: u21 = 0,
    }),
    /// Status Register
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Rx-Packet available
        RXP: u1,
        /// Tx-Packet space available
        TXP: u1,
        /// Duplex Packet
        DXP: u1,
        /// End Of Transfer
        EOT: u1,
        /// Transmission Transfer Filled
        TXTF: u1,
        /// Underrun at slave transmission mode
        UDR: u1,
        /// Overrun
        OVR: u1,
        /// CRC Error
        CRCE: u1,
        /// TI frame format error
        TIFRE: u1,
        /// Mode Fault
        MODF: u1,
        /// Additional number of SPI data to be transacted was reload
        TSERF: u1,
        /// SUSPend
        SUSP: u1,
        /// TxFIFO transmission complete
        TXC: u1,
        /// RxFIFO Packing LeVeL
        RXPLVL: RXPLVL,
        /// RxFIFO Word Not Empty
        RXWNE: RXWNE,
        /// Number of data frames remaining in current TSIZE session
        CTSIZE: u16,
    }),
    /// Interrupt/Status Flags Clear Register
    /// offset: 0x18
    IFCR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// End Of Transfer flag clear
        EOTC: u1,
        /// Transmission Transfer Filled flag clear
        TXTFC: u1,
        /// Underrun flag clear
        UDRC: u1,
        /// Overrun flag clear
        OVRC: u1,
        /// CRC Error flag clear
        CRCEC: u1,
        /// TI frame format error flag clear
        TIFREC: u1,
        /// Mode Fault flag clear
        MODFC: u1,
        /// TSERFC flag clear
        TSERFC: u1,
        /// SUSPend flag clear
        SUSPC: u1,
        padding: u20 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// Transmit Data Register - half-word sized
    /// offset: 0x20
    TXDR16: u32,
    /// offset: 0x24
    reserved36: [12]u8,
    /// Receive Data Register - half-word sized
    /// offset: 0x30
    RXDR16: u32,
    /// offset: 0x34
    reserved52: [12]u8,
    /// Polynomial Register
    /// offset: 0x40
    CRCPOLY: mmio.Mmio(packed struct(u32) {
        /// CRC polynomial register
        CRCPOLY: u32,
    }),
    /// Transmitter CRC Register
    /// offset: 0x44
    TXCRC: mmio.Mmio(packed struct(u32) {
        /// CRC register for transmitter
        TXCRC: u32,
    }),
    /// Receiver CRC Register
    /// offset: 0x48
    RXCRC: mmio.Mmio(packed struct(u32) {
        /// CRC register for receiver
        RXCRC: u32,
    }),
    /// Underrun Data Register
    /// offset: 0x4c
    UDRDR: mmio.Mmio(packed struct(u32) {
        /// Data at slave underrun condition
        UDRDR: u32,
    }),
    /// I2S Configuration Register
    /// offset: 0x50
    I2SCFGR: mmio.Mmio(packed struct(u32) {
        /// I2S mode selection
        I2SMOD: u1,
        /// I2S configuration mode
        I2SCFG: I2SCFG,
        /// I2S standard selection
        I2SSTD: I2SSTD,
        reserved7: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: PCMSYNC,
        /// Data length to be transferred
        DATLEN: DATLEN,
        /// Channel length (number of bits per audio channel)
        CHLEN: CHLEN,
        /// Serial audio clock polarity
        CKPOL: CKPOL,
        /// Fixed channel length in slave
        FIXCH: FIXCH,
        /// Word select inversion
        WSINV: u1,
        /// Data format
        DATFMT: DATFMT,
        reserved16: u1 = 0,
        /// I2S linear prescaler
        I2SDIV: u8,
        /// Odd factor for the prescaler
        ODD: ODD,
        /// Master clock output enable
        MCKOE: u1,
        padding: u6 = 0,
    }),
};
