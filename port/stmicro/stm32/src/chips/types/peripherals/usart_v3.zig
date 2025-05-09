const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ABRMOD = enum(u2) {
    /// Measurement of the start bit is used to detect the baud rate
    Start = 0x0,
    /// Falling edge to falling edge measurement
    Edge = 0x1,
    /// 0x7F frame detection
    Frame7F = 0x2,
    /// 0x55 frame detection
    Frame55 = 0x3,
};

pub const ADDM = enum(u1) {
    /// 4-bit address detection
    Bit4 = 0x0,
    /// 7-bit address detection
    Bit7 = 0x1,
};

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

pub const DEP = enum(u1) {
    /// DE signal is active high
    High = 0x0,
    /// DE signal is active low
    Low = 0x1,
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

pub const M1 = enum(u1) {
    /// Use M0 to set the data bits
    M0 = 0x0,
    /// 1 start bit, 7 data bits, n stop bits
    Bit7 = 0x1,
};

pub const MSBFIRST = enum(u1) {
    /// data is transmitted/received with data bit 0 first, following the start bit
    LSB = 0x0,
    /// data is transmitted/received with MSB (bit 7/8/9) first, following the start bit
    MSB = 0x1,
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

pub const WUS = enum(u2) {
    /// WUF active on address match
    Address = 0x0,
    /// WuF active on Start bit detection
    Start = 0x2,
    /// WUF active on RXNE
    RXNE = 0x3,
    _,
};

/// Low-power Universal synchronous asynchronous receiver transmitter
pub const LPUART = extern struct {
    /// Control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// USART enable
        UE: u1,
        /// USART enable in Stop mode
        UESM: u1,
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
        /// Mute mode enable
        MME: u1,
        /// Character match interrupt enable
        CMIE: u1,
        /// Oversampling mode
        OVER8: OVER8,
        /// Driver Enable deassertion time
        DEDT: u5,
        /// Driver Enable assertion time
        DEAT: u5,
        /// Receiver timeout interrupt enable
        RTOIE: u1,
        /// End of Block interrupt enable
        EOBIE: u1,
        /// Word length
        M1: M1,
        padding: u3 = 0,
    }),
    /// Control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM: ADDM,
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
        /// Swap TX/RX pins
        SWAP: u1,
        /// RX pin active level inversion
        RXINV: u1,
        /// TX pin active level inversion
        TXINV: u1,
        /// Binary data inversion
        DATAINV: u1,
        /// Most significant bit first
        MSBFIRST: MSBFIRST,
        /// Auto baud rate enable
        ABREN: u1,
        /// Auto baud rate mode
        ABRMOD: ABRMOD,
        /// Receiver timeout enable
        RTOEN: u1,
        /// Address of the USART node
        ADD: u8,
    }),
    /// Control register 3
    /// offset: 0x08
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
        /// Overrun Disable
        OVRDIS: u1,
        /// DMA Disable on Reception Error
        DDRE: u1,
        /// Driver enable mode
        DEM: u1,
        /// Driver enable polarity selection
        DEP: DEP,
        reserved17: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: WUS,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1,
        padding: u9 = 0,
    }),
    /// Baud rate register
    /// offset: 0x0c
    BRR: mmio.Mmio(packed struct(u32) {
        /// USARTDIV
        BRR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x10
    reserved16: [8]u8,
    /// Request register
    /// offset: 0x18
    RQR: mmio.Mmio(packed struct(u32) {
        /// Auto baud rate request. Resets the ABRF flag in the USART_ISR and request an automatic baud rate measurement on the next received data frame.
        ABRRQ: u1,
        /// Send break request. Sets the SBKF flag and request to send a BREAK on the line, as soon as the transmit machine is available
        SBKRQ: u1,
        /// Mute mode request. Puts the USART in mute mode and sets the RWU flag.
        MMRQ: u1,
        /// Receive data flush request. Clears the RXNE flag. This allows to discard the received data without reading it, and avoid an overrun condition
        RXFRQ: u1,
        /// Transmit data flush request. Sets the TXE flags. This allows to discard the transmit data.
        TXFRQ: u1,
        padding: u27 = 0,
    }),
    /// Interrupt & status register
    /// offset: 0x1c
    ISR: mmio.Mmio(packed struct(u32) {
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
        /// CTS interrupt flag
        CTSIF: u1,
        /// CTS flag
        CTS: u1,
        /// Receiver timeout
        RTOF: u1,
        /// End of block flag
        EOBF: u1,
        reserved14: u1 = 0,
        /// Auto baud rate error
        ABRE: u1,
        /// Auto baud rate flag
        ABRF: u1,
        /// Busy flag
        BUSY: u1,
        /// character match flag
        CMF: u1,
        /// Send break flag
        SBKF: u1,
        /// Receiver wakeup from Mute mode
        RWU: RWU,
        /// Wakeup from Stop mode flag
        WUF: u1,
        /// Transmit enable acknowledge flag
        TEACK: u1,
        /// Receive enable acknowledge flag
        REACK: u1,
        padding: u9 = 0,
    }),
    /// Interrupt flag clear register
    /// offset: 0x20
    ICR: mmio.Mmio(packed struct(u32) {
        /// Parity error clear flag
        PE: u1,
        /// Framing error clear flag
        FE: u1,
        /// Noise error clear flag
        NE: u1,
        /// Overrun error clear flag
        ORE: u1,
        /// Idle line detected clear flag
        IDLE: u1,
        reserved6: u1 = 0,
        /// Transmission complete clear flag
        TC: u1,
        reserved8: u1 = 0,
        /// LIN break detection clear flag
        LBD: u1,
        /// CTS clear flag
        CTS: u1,
        reserved11: u1 = 0,
        /// Receiver timeout clear flag
        RTOF: u1,
        /// End of block clear flag
        EOBF: u1,
        reserved17: u4 = 0,
        /// Character match clear flag
        CMF: u1,
        reserved20: u2 = 0,
        /// Wakeup from Stop mode clear flag
        WUF: u1,
        padding: u11 = 0,
    }),
    /// Receive data register
    /// offset: 0x24
    RDR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
    /// Transmit data register
    /// offset: 0x28
    TDR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART = extern struct {
    /// Control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// USART enable
        UE: u1,
        /// USART enable in Stop mode
        UESM: u1,
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
        /// Mute mode enable
        MME: u1,
        /// Character match interrupt enable
        CMIE: u1,
        /// Oversampling mode
        OVER8: OVER8,
        /// Driver Enable deassertion time
        DEDT: u5,
        /// Driver Enable assertion time
        DEAT: u5,
        /// Receiver timeout interrupt enable
        RTOIE: u1,
        /// End of Block interrupt enable
        EOBIE: u1,
        /// Word length
        M1: M1,
        padding: u3 = 0,
    }),
    /// Control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// 7-bit Address Detection/4-bit Address Detection
        ADDM: ADDM,
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
        /// Swap TX/RX pins
        SWAP: u1,
        /// RX pin active level inversion
        RXINV: u1,
        /// TX pin active level inversion
        TXINV: u1,
        /// Binary data inversion
        DATAINV: u1,
        /// Most significant bit first
        MSBFIRST: MSBFIRST,
        /// Auto baud rate enable
        ABREN: u1,
        /// Auto baud rate mode
        ABRMOD: ABRMOD,
        /// Receiver timeout enable
        RTOEN: u1,
        /// Address of the USART node
        ADD: u8,
    }),
    /// Control register 3
    /// offset: 0x08
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
        /// Overrun Disable
        OVRDIS: u1,
        /// DMA Disable on Reception Error
        DDRE: u1,
        /// Driver enable mode
        DEM: u1,
        /// Driver enable polarity selection
        DEP: DEP,
        reserved17: u1 = 0,
        /// Smartcard auto-retry count
        SCARCNT: u3,
        /// Wakeup from Stop mode interrupt flag selection
        WUS: WUS,
        /// Wakeup from Stop mode interrupt enable
        WUFIE: u1,
        padding: u9 = 0,
    }),
    /// Baud rate register
    /// offset: 0x0c
    BRR: mmio.Mmio(packed struct(u32) {
        /// USARTDIV
        BRR: u16,
        padding: u16 = 0,
    }),
    /// Guard time and prescaler register
    /// offset: 0x10
    GTPR: mmio.Mmio(packed struct(u32) {
        /// Prescaler value
        PSC: u8,
        /// Guard time value
        GT: u8,
        padding: u16 = 0,
    }),
    /// Receiver timeout register
    /// offset: 0x14
    RTOR: mmio.Mmio(packed struct(u32) {
        /// Receiver timeout value
        RTO: u24,
        /// Block Length
        BLEN: u8,
    }),
    /// Request register
    /// offset: 0x18
    RQR: mmio.Mmio(packed struct(u32) {
        /// Auto baud rate request. Resets the ABRF flag in the USART_ISR and request an automatic baud rate measurement on the next received data frame.
        ABRRQ: u1,
        /// Send break request. Sets the SBKF flag and request to send a BREAK on the line, as soon as the transmit machine is available
        SBKRQ: u1,
        /// Mute mode request. Puts the USART in mute mode and sets the RWU flag.
        MMRQ: u1,
        /// Receive data flush request. Clears the RXNE flag. This allows to discard the received data without reading it, and avoid an overrun condition
        RXFRQ: u1,
        /// Transmit data flush request. Sets the TXE flags. This allows to discard the transmit data.
        TXFRQ: u1,
        padding: u27 = 0,
    }),
    /// Interrupt & status register
    /// offset: 0x1c
    ISR: mmio.Mmio(packed struct(u32) {
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
        /// CTS interrupt flag
        CTSIF: u1,
        /// CTS flag
        CTS: u1,
        /// Receiver timeout
        RTOF: u1,
        /// End of block flag
        EOBF: u1,
        reserved14: u1 = 0,
        /// Auto baud rate error
        ABRE: u1,
        /// Auto baud rate flag
        ABRF: u1,
        /// Busy flag
        BUSY: u1,
        /// character match flag
        CMF: u1,
        /// Send break flag
        SBKF: u1,
        /// Receiver wakeup from Mute mode
        RWU: RWU,
        /// Wakeup from Stop mode flag
        WUF: u1,
        /// Transmit enable acknowledge flag
        TEACK: u1,
        /// Receive enable acknowledge flag
        REACK: u1,
        padding: u9 = 0,
    }),
    /// Interrupt flag clear register
    /// offset: 0x20
    ICR: mmio.Mmio(packed struct(u32) {
        /// Parity error clear flag
        PE: u1,
        /// Framing error clear flag
        FE: u1,
        /// Noise error clear flag
        NE: u1,
        /// Overrun error clear flag
        ORE: u1,
        /// Idle line detected clear flag
        IDLE: u1,
        reserved6: u1 = 0,
        /// Transmission complete clear flag
        TC: u1,
        reserved8: u1 = 0,
        /// LIN break detection clear flag
        LBD: u1,
        /// CTS clear flag
        CTS: u1,
        reserved11: u1 = 0,
        /// Receiver timeout clear flag
        RTOF: u1,
        /// End of block clear flag
        EOBF: u1,
        reserved17: u4 = 0,
        /// Character match clear flag
        CMF: u1,
        reserved20: u2 = 0,
        /// Wakeup from Stop mode clear flag
        WUF: u1,
        padding: u11 = 0,
    }),
    /// Receive data register
    /// offset: 0x24
    RDR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
    /// Transmit data register
    /// offset: 0x28
    TDR: mmio.Mmio(packed struct(u32) {
        /// Data value
        DR: u9,
        padding: u23 = 0,
    }),
};
