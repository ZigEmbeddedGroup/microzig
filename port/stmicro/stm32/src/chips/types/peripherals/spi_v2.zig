const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const BIDIMODE = enum(u1) {
    /// 2-line unidirectional data mode selected
    Unidirectional = 0x0,
    /// 1-line bidirectional data mode selected
    Bidirectional = 0x1,
};

pub const BIDIOE = enum(u1) {
    /// Output disabled (receive-only mode)
    Receive = 0x0,
    /// Output enabled (transmit-only mode)
    Transmit = 0x1,
};

pub const BR = enum(u3) {
    /// f_PCLK / 2
    Div2 = 0x0,
    /// f_PCLK / 4
    Div4 = 0x1,
    /// f_PCLK / 8
    Div8 = 0x2,
    /// f_PCLK / 16
    Div16 = 0x3,
    /// f_PCLK / 32
    Div32 = 0x4,
    /// f_PCLK / 64
    Div64 = 0x5,
    /// f_PCLK / 128
    Div128 = 0x6,
    /// f_PCLK / 256
    Div256 = 0x7,
};

pub const CHLEN = enum(u1) {
    /// 16-bit wide
    Bits16 = 0x0,
    /// 32-bit wide
    Bits32 = 0x1,
};

pub const CHSIDE = enum(u1) {
    /// Channel left has to be transmitted or has been received
    Left = 0x0,
    /// Channel right has to be transmitted or has been received
    Right = 0x1,
};

pub const CKPOL = enum(u1) {
    /// I2S clock inactive state is low level
    IdleLow = 0x0,
    /// I2S clock inactive state is high level
    IdleHigh = 0x1,
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

pub const CRCL = enum(u1) {
    /// 8-bit CRC length
    Bits8 = 0x0,
    /// 16-bit CRC length
    Bits16 = 0x1,
};

pub const CRCNEXT = enum(u1) {
    /// Next transmit value is from Tx buffer
    TxBuffer = 0x0,
    /// Next transmit value is from Tx CRC register
    CRC = 0x1,
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

pub const DS = enum(u4) {
    /// 4-bit
    Bits4 = 0x3,
    /// 5-bit
    Bits5 = 0x4,
    /// 6-bit
    Bits6 = 0x5,
    /// 7-bit
    Bits7 = 0x6,
    /// 8-bit
    Bits8 = 0x7,
    /// 9-bit
    Bits9 = 0x8,
    /// 10-bit
    Bits10 = 0x9,
    /// 11-bit
    Bits11 = 0xa,
    /// 12-bit
    Bits12 = 0xb,
    /// 13-bit
    Bits13 = 0xc,
    /// 14-bit
    Bits14 = 0xd,
    /// 15-bit
    Bits15 = 0xe,
    /// 16-bit
    Bits16 = 0xf,
    _,
};

pub const FRF = enum(u1) {
    /// SPI Motorola mode
    Motorola = 0x0,
    /// SPI TI mode
    TI = 0x1,
};

pub const FRLVL = enum(u2) {
    /// Rx FIFO Empty
    Empty = 0x0,
    /// Rx 1/4 FIFO
    Quarter = 0x1,
    /// Rx 1/2 FIFO
    Half = 0x2,
    /// Rx FIFO full
    Full = 0x3,
};

pub const FRXTH = enum(u1) {
    /// RXNE event is generated if the FIFO level is greater than or equal to 1/2 (16-bit)
    Half = 0x0,
    /// RXNE event is generated if the FIFO level is greater than or equal to 1/4 (8-bit)
    Quarter = 0x1,
};

pub const FTLVL = enum(u2) {
    /// Tx FIFO Empty
    Empty = 0x0,
    /// Tx 1/4 FIFO
    Quarter = 0x1,
    /// Tx 1/2 FIFO
    Half = 0x2,
    /// Tx FIFO full
    Full = 0x3,
};

pub const ISCFG = enum(u2) {
    /// Slave - transmit
    SlaveTx = 0x0,
    /// Slave - receive
    SlaveRx = 0x1,
    /// Master - transmit
    MasterTx = 0x2,
    /// Master - receive
    MasterRx = 0x3,
};

pub const ISMOD = enum(u1) {
    /// SPI mode is selected
    SPIMode = 0x0,
    /// I2S mode is selected
    I2SMode = 0x1,
};

pub const ISSTD = enum(u2) {
    /// I2S Philips standard
    Philips = 0x0,
    /// MSB justified standard
    MSB = 0x1,
    /// LSB justified standard
    LSB = 0x2,
    /// PCM standard
    PCM = 0x3,
};

pub const LDMA_RX = enum(u1) {
    /// Number of data to transfer for receive is even
    Even = 0x0,
    /// Number of data to transfer for receive is odd
    Odd = 0x1,
};

pub const LDMA_TX = enum(u1) {
    /// Number of data to transfer for transmit is even
    Even = 0x0,
    /// Number of data to transfer for transmit is odd
    Odd = 0x1,
};

pub const LSBFIRST = enum(u1) {
    /// Data is transmitted/received with the MSB first
    MSBFirst = 0x0,
    /// Data is transmitted/received with the LSB first
    LSBFirst = 0x1,
};

pub const MSTR = enum(u1) {
    /// Slave configuration
    Slave = 0x0,
    /// Master configuration
    Master = 0x1,
};

pub const ODD = enum(u1) {
    /// Real divider value is I2SDIV * 2
    Even = 0x0,
    /// Real divider value is (I2SDIV * 2) + 1
    Odd = 0x1,
};

pub const PCMSYNC = enum(u1) {
    /// Short frame synchronisation
    Short = 0x0,
    /// Long frame synchronisation
    Long = 0x1,
};

pub const RXONLY = enum(u1) {
    /// Full duplex (Transmit and receive)
    FullDuplex = 0x0,
    /// Output disabled (Receive-only mode)
    OutputDisabled = 0x1,
};

/// Serial peripheral interface
pub const SPI = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Clock phase
        CPHA: CPHA,
        /// Clock polarity
        CPOL: CPOL,
        /// Master selection
        MSTR: MSTR,
        /// Baud rate control
        BR: BR,
        /// SPI enable
        SPE: u1,
        /// Frame format
        LSBFIRST: LSBFIRST,
        /// Internal slave select
        SSI: u1,
        /// Software slave management
        SSM: u1,
        /// Receive only
        RXONLY: RXONLY,
        /// CRC length
        CRCL: CRCL,
        /// CRC transfer next
        CRCNEXT: CRCNEXT,
        /// Hardware CRC calculation enable
        CRCEN: u1,
        /// Select the direction of transfer in bidirectional mode
        BIDIOE: BIDIOE,
        /// Bidirectional data mode enable
        BIDIMODE: BIDIMODE,
        padding: u16 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Rx buffer DMA enable
        RXDMAEN: u1,
        /// Tx buffer DMA enable
        TXDMAEN: u1,
        /// SS output enable
        SSOE: u1,
        /// NSS pulse management
        NSSP: u1,
        /// Frame format
        FRF: FRF,
        /// Error interrupt enable
        ERRIE: u1,
        /// RX buffer not empty interrupt enable
        RXNEIE: u1,
        /// Tx buffer empty interrupt enable
        TXEIE: u1,
        /// Data size
        DS: DS,
        /// FIFO reception threshold
        FRXTH: FRXTH,
        /// Last DMA transfer for reception
        LDMA_RX: LDMA_RX,
        /// Last DMA transfer for transmission
        LDMA_TX: LDMA_TX,
        padding: u17 = 0,
    }),
    /// status register
    /// offset: 0x08
    SR: mmio.Mmio(packed struct(u32) {
        /// Receive buffer not empty
        RXNE: u1,
        /// Transmit buffer empty
        TXE: u1,
        /// Channel side
        CHSIDE: CHSIDE,
        /// Underrun flag
        UDR: u1,
        /// CRC error flag
        CRCERR: u1,
        /// Mode fault
        MODF: u1,
        /// Overrun flag
        OVR: u1,
        /// Busy flag
        BSY: u1,
        /// frame format error
        FRE: u1,
        /// FIFO reception level
        FRLVL: FRLVL,
        /// FIFO Transmission Level
        FTLVL: FTLVL,
        padding: u19 = 0,
    }),
    /// data register - half-word sized
    /// offset: 0x0c
    DR16: u32,
    /// CRC polynomial register
    /// offset: 0x10
    CRCPR: mmio.Mmio(packed struct(u32) {
        /// CRC polynomial register
        CRCPOLY: u16,
        padding: u16 = 0,
    }),
    /// RX CRC register
    /// offset: 0x14
    RXCRCR: mmio.Mmio(packed struct(u32) {
        /// Rx CRC register
        RxCRC: u16,
        padding: u16 = 0,
    }),
    /// TX CRC register
    /// offset: 0x18
    TXCRCR: mmio.Mmio(packed struct(u32) {
        /// Tx CRC register
        TxCRC: u16,
        padding: u16 = 0,
    }),
    /// I2S configuration register
    /// offset: 0x1c
    I2SCFGR: mmio.Mmio(packed struct(u32) {
        /// Channel length (number of bits per audio channel)
        CHLEN: CHLEN,
        /// Data length to be transferred
        DATLEN: DATLEN,
        /// Steady state clock polarity
        CKPOL: CKPOL,
        /// I2S standard selection
        I2SSTD: ISSTD,
        reserved7: u1 = 0,
        /// PCM frame synchronization
        PCMSYNC: PCMSYNC,
        /// I2S configuration mode
        I2SCFG: ISCFG,
        /// I2S Enabled
        I2SE: u1,
        /// I2S mode selection
        I2SMOD: ISMOD,
        /// Asynchronous start enable
        ASTRTEN: u1,
        padding: u19 = 0,
    }),
    /// I2S prescaler register
    /// offset: 0x20
    I2SPR: mmio.Mmio(packed struct(u32) {
        /// I2S Linear prescaler
        I2SDIV: u8,
        /// Odd factor for the prescaler
        ODD: ODD,
        /// Master clock output enable
        MCKOE: u1,
        padding: u22 = 0,
    }),
};
