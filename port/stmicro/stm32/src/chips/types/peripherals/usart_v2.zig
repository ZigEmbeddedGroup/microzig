const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const CPHA = enum(u1) {
    /// The first clock transition is the first data capture edge
    First = 0x0,
    /// The second clock transition is the first data capture edge
    Second = 0x1,
};

pub const CPOL = enum(u1) {
    /// Steady low value on CK pin outside transmission window
    Low = 0x0,
    /// Steady high value on CK pin outside transmission window
    High = 0x1,
};

pub const IRLP = enum(u1) {
    /// Normal mode
    Normal = 0x0,
    /// Low-power mode
    LowPower = 0x1,
};

pub const LBDL = enum(u1) {
    /// 10-bit break detection
    Bit10 = 0x0,
    /// 11-bit break detection
    Bit11 = 0x1,
};

pub const M0 = enum(u1) {
    /// 1 start bit, 8 data bits, n stop bits
    Bit8 = 0x0,
    /// 1 start bit, 9 data bits, n stop bits
    Bit9 = 0x1,
};

pub const OVER8 = enum(u1) {
    /// Oversampling by 16
    Oversampling16 = 0x0,
    /// Oversampling by 8
    Oversampling8 = 0x1,
};

pub const PS = enum(u1) {
    /// Even parity
    Even = 0x0,
    /// Odd parity
    Odd = 0x1,
};

pub const RWU = enum(u1) {
    /// Receiver in active mode
    Active = 0x0,
    /// Receiver in mute mode
    Mute = 0x1,
};

pub const STOP = enum(u2) {
    /// 1 stop bit
    Stop1 = 0x0,
    /// 0.5 stop bits
    Stop0p5 = 0x1,
    /// 2 stop bits
    Stop2 = 0x2,
    /// 1.5 stop bits
    Stop1p5 = 0x3,
};

pub const WAKE = enum(u1) {
    /// USART wakeup on idle line
    IdleLine = 0x0,
    /// USART wakeup on address mark
    AddressMark = 0x1,
};

/// Universal asynchronous receiver transmitter
pub const UART = extern struct {
    /// Status register
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// Parity error
        PE: u1,
        /// Framing error
        FE: u1,
        /// Noise error flag
        NE: u1,
        /// Overrun error
        ORE: u1,
        /// Idle line detected
        IDLE: u1,
        /// Read data register not empty
        RXNE: u1,
        /// Transmission complete
        TC: u1,
        /// Transmit data register empty
        TXE: u1,
        /// LIN break detection flag
        LBD: u1,
        /// CTS flag
        CTS: u1,
        padding: u22 = 0,
    }),
    /// Data register
    /// offset: 0x04
    DR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
    /// Baud rate register
    /// offset: 0x08
    BRR: mmio.Mmio(packed struct(u32) {
        /// USARTDIV
        BRR: u16,
        padding: u16 = 0,
    }),
    /// Control register 1
    /// offset: 0x0c
    CR1: mmio.Mmio(packed struct(u32) {
        /// Send break
        SBK: u1,
        /// Receiver wakeup
        RWU: RWU,
        /// Receiver enable
        RE: u1,
        /// Transmitter enable
        TE: u1,
        /// IDLE interrupt enable
        IDLEIE: u1,
        /// RXNE interrupt enable
        RXNEIE: u1,
        /// Transmission complete interrupt enable
        TCIE: u1,
        /// TXE interrupt enable
        TXEIE: u1,
        /// PE interrupt enable
        PEIE: u1,
        /// Parity selection
        PS: PS,
        /// Parity control enable
        PCE: u1,
        /// Receiver wakeup method
        WAKE: WAKE,
        /// Word length
        M0: M0,
        /// USART enable
        UE: u1,
        reserved15: u1 = 0,
        /// Oversampling mode
        OVER8: OVER8,
        padding: u16 = 0,
    }),
    /// Control register 2
    /// offset: 0x10
    CR2: mmio.Mmio(packed struct(u32) {
        /// Address of the USART node
        ADD: u4,
        reserved5: u1 = 0,
        /// Line break detection length
        LBDL: LBDL,
        /// LIN break detection interrupt enable
        LBDIE: u1,
        reserved12: u5 = 0,
        /// STOP bits
        STOP: STOP,
        /// LIN mode enable
        LINEN: u1,
        padding: u17 = 0,
    }),
    /// Control register 3
    /// offset: 0x14
    CR3: mmio.Mmio(packed struct(u32) {
        /// Error interrupt enable
        EIE: u1,
        /// IrDA mode enable
        IREN: u1,
        /// IrDA low-power
        IRLP: IRLP,
        /// Half-duplex selection
        HDSEL: u1,
        reserved6: u2 = 0,
        /// DMA enable receiver
        DMAR: u1,
        /// DMA enable transmitter
        DMAT: u1,
        padding: u24 = 0,
    }),
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART = extern struct {
    /// Status register
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// Parity error
        PE: u1,
        /// Framing error
        FE: u1,
        /// Noise error flag
        NE: u1,
        /// Overrun error
        ORE: u1,
        /// Idle line detected
        IDLE: u1,
        /// Read data register not empty
        RXNE: u1,
        /// Transmission complete
        TC: u1,
        /// Transmit data register empty
        TXE: u1,
        /// LIN break detection flag
        LBD: u1,
        /// CTS flag
        CTS: u1,
        padding: u22 = 0,
    }),
    /// Data register
    /// offset: 0x04
    DR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
    /// Baud rate register
    /// offset: 0x08
    BRR: mmio.Mmio(packed struct(u32) {
        /// USARTDIV
        BRR: u16,
        padding: u16 = 0,
    }),
    /// Control register 1
    /// offset: 0x0c
    CR1: mmio.Mmio(packed struct(u32) {
        /// Send break
        SBK: u1,
        /// Receiver wakeup
        RWU: RWU,
        /// Receiver enable
        RE: u1,
        /// Transmitter enable
        TE: u1,
        /// IDLE interrupt enable
        IDLEIE: u1,
        /// RXNE interrupt enable
        RXNEIE: u1,
        /// Transmission complete interrupt enable
        TCIE: u1,
        /// TXE interrupt enable
        TXEIE: u1,
        /// PE interrupt enable
        PEIE: u1,
        /// Parity selection
        PS: PS,
        /// Parity control enable
        PCE: u1,
        /// Receiver wakeup method
        WAKE: WAKE,
        /// Word length
        M0: M0,
        /// USART enable
        UE: u1,
        reserved15: u1 = 0,
        /// Oversampling mode
        OVER8: OVER8,
        padding: u16 = 0,
    }),
    /// Control register 2
    /// offset: 0x10
    CR2: mmio.Mmio(packed struct(u32) {
        /// Address of the USART node
        ADD: u4,
        reserved5: u1 = 0,
        /// Line break detection length
        LBDL: LBDL,
        /// LIN break detection interrupt enable
        LBDIE: u1,
        reserved8: u1 = 0,
        /// Last bit clock pulse
        LBCL: u1,
        /// Clock phase
        CPHA: CPHA,
        /// Clock polarity
        CPOL: CPOL,
        /// Clock enable
        CLKEN: u1,
        /// STOP bits
        STOP: STOP,
        /// LIN mode enable
        LINEN: u1,
        padding: u17 = 0,
    }),
    /// Control register 3
    /// offset: 0x14
    CR3: mmio.Mmio(packed struct(u32) {
        /// Error interrupt enable
        EIE: u1,
        /// IrDA mode enable
        IREN: u1,
        /// IrDA low-power
        IRLP: IRLP,
        /// Half-duplex selection
        HDSEL: u1,
        /// Smartcard NACK enable
        NACK: u1,
        /// Smartcard mode enable
        SCEN: u1,
        /// DMA enable receiver
        DMAR: u1,
        /// DMA enable transmitter
        DMAT: u1,
        /// RTS enable
        RTSE: u1,
        /// CTS enable
        CTSE: u1,
        /// CTS interrupt enable
        CTSIE: u1,
        /// One sample bit method enable
        ONEBIT: u1,
        padding: u20 = 0,
    }),
    /// Guard time and prescaler register
    /// offset: 0x18
    GTPR: mmio.Mmio(packed struct(u32) {
        /// Prescaler value
        PSC: u8,
        /// Guard time value
        GT: u8,
        padding: u16 = 0,
    }),
};
