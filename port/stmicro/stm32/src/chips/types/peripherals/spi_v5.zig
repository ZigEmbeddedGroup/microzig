const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

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
    /// CK to 0 when idle
    IdleLow = 0x0,
    /// CK to 1 when idle
    IdleHigh = 0x1,
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

pub const RCRCINI = enum(u1) {
    /// All zeros RX CRC initialization pattern
    AllZeros = 0x0,
    /// All ones RX CRC initialization pattern
    AllOnes = 0x1,
};

pub const RDIOM = enum(u1) {
    /// RDY signal is defined internally fixed as permanently active (RDIOP setting has no effect)
    PermanentlyActive = 0x0,
    /// RDY signal is overtaken from alternate function input (at master case) or output (at slave case) of the dedicated pin (RDIOP setting takes effect)
    FromInput = 0x1,
};

pub const RDIOP = enum(u1) {
    /// high level of the signal means the slave is ready for communication
    ReadyHigh = 0x0,
    /// low level of the signal means the slave is ready for communication
    ReadyLow = 0x1,
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

pub const TRIGPOL = enum(u1) {
    /// trigger is active on raising edge
    RisingEdge = 0x0,
    /// trigger is active on falling edge
    FallingEdge = 0x1,
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
        padding: u16 = 0,
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
        reserved14: u3 = 0,
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
        /// bypass of the prescaler at master baud rate clock generator
        BPASS: u1,
    }),
    /// configuration register 2
    /// offset: 0x0c
    CFG2: mmio.Mmio(packed struct(u32) {
        /// Master SS Idleness
        MSSI: u4,
        /// Master Inter-Data Idleness
        MIDI: u4,
        reserved13: u5 = 0,
        /// RDY signal input/output management Note: When DSIZE at the CFG1 register is configured shorter than 8-bit, the RDIOM bit has to be kept at zero.
        RDIOM: RDIOM,
        /// RDY signal input/output polarity
        RDIOP: RDIOP,
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
        padding: u22 = 0,
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
        reserved11: u1 = 0,
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
        reserved11: u1 = 0,
        /// SUSPend flag clear
        SUSPC: u1,
        padding: u20 = 0,
    }),
    /// offset: 0x1c
    AUTOCR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// trigger selection (refer ). ... Note: these bits can be written only when SPE = 0.
        TRIGSEL: u4,
        /// trigger polarity Note: This bit can be written only when SPE = 0.
        TRIGPOL: TRIGPOL,
        /// trigger of CSTART control enable Note: if user can't prevent trigger event during write, the TRIGEN has to be changed when SPI is disabled
        TRIGEN: u1,
        padding: u10 = 0,
    }),
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
};
