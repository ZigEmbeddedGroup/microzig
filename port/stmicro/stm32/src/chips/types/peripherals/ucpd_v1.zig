const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ANAMODE = enum(u1) {
    /// Source
    Source = 0x0,
    /// Sink
    Sink = 0x1,
};

pub const CCENABLE = enum(u2) {
    /// Disable both PHYs
    Disabled = 0x0,
    /// Enable CC1 PHY
    Cc1 = 0x1,
    /// Enable CC2 PHY
    Cc2 = 0x2,
    /// Enable CC1 and CC2 PHY
    Both = 0x3,
};

pub const PHYCCSEL = enum(u1) {
    /// Use CC1 IO for Power Delivery communication
    Cc1 = 0x0,
    /// Use CC2 IO for Power Delivery communication
    Cc2 = 0x1,
};

pub const PSC_USBPDCLK = enum(u3) {
    /// 1 (bypass)
    Div1 = 0x0,
    /// 2
    Div2 = 0x1,
    /// 4
    Div4 = 0x2,
    /// 8
    Div8 = 0x3,
    /// 16
    Div16 = 0x4,
    _,
};

pub const RXORDSET = enum(u3) {
    /// SOP code detected in receiver
    Sop = 0x0,
    /// SOP' code detected in receiver
    SopPrime = 0x1,
    /// SOP'' code detected in receiver
    SopDoublePrime = 0x2,
    /// SOP'_Debug detected in receiver
    SopPrimeDebug = 0x3,
    /// SOP''_Debug detected in receiver
    SopDoublePrimeDebug = 0x4,
    /// Cable Reset detected in receiver
    CableReset = 0x5,
    /// SOP extension#1 detected in receiver
    Ext1 = 0x6,
    /// SOP extension#2 detected in receiver
    Ext2 = 0x7,
};

pub const RXSOPKINVALID = enum(u3) {
    /// No K‑code corrupted
    None = 0x0,
    /// First K‑code corrupted
    First = 0x1,
    /// Second K‑code corrupted
    Second = 0x2,
    /// Third K‑code corrupted
    Third = 0x3,
    /// Fourth K‑code corrupted
    Fourth = 0x4,
    _,
};

pub const TXMODE = enum(u2) {
    /// Transmission of Tx packet previously defined in other registers
    Packet = 0x0,
    /// Cable Reset sequence
    CableReset = 0x1,
    /// BIST test sequence (BIST Carrier Mode 2)
    Bist = 0x2,
    _,
};

pub const TYPEC_VSTATE_CC = enum(u2) {
    /// Lowest
    Lowest = 0x0,
    /// Low
    Low = 0x1,
    /// High
    High = 0x2,
    /// Highest
    Highest = 0x3,
};

/// USB Power Delivery interface
pub const UCPD = extern struct {
    /// configuration register 1
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Division ratio for producing half-bit clock The bitfield determines the division ratio (the bitfield value plus one) of a clk divider producing half-bit clock (hbit_clk).
        HBITCLKDIV: u6,
        /// Division ratio for producing inter-frame gap timer clock The bitfield determines the division ratio (the bitfield value minus one) of a clk divider producing inter-frame gap timer clock (tInterFrameGap). The division ratio 15 is to apply for Tx clock at the USB PD 2.0 specification nominal value. The division ratios below 15 are to apply for Tx clock below nominal, and the division ratios above 15 for Tx clock above nominal.
        IFRGAP: u5,
        /// Transition window duration The bitfield determines the division ratio (the bitfield value minus one) of a hbit_clk divider producing tTransitionWindow interval. Set a value that produces an interval of 12 to 20 us, taking into account the clk frequency and the HBITCLKDIV[5:0] bitfield setting.
        TRANSWIN: u5,
        reserved17: u1 = 0,
        /// Pre-scaler division ratio for generating clk The bitfield determines the division ratio of a kernel clock pre-scaler producing peripheral clock (clk). It is recommended to use the pre-scaler so as to set the clk frequency in the range from 6 to 9 MHz.
        PSC_USBPDCLK: PSC_USBPDCLK,
        /// Receiver ordered set enable The bitfield determines the types of ordered sets that the receiver must detect. When set/cleared, each bit enables/disables a specific function: 0bxxxxxxxx1: SOP detect enabled 0bxxxxxxx1x: SOP' detect enabled 0bxxxxxx1xx: SOP'' detect enabled 0bxxxxx1xxx: Hard Reset detect enabled 0bxxxx1xxxx: Cable Detect reset enabled 0bxxx1xxxxx: SOP'_Debug enabled 0bxx1xxxxxx: SOP''_Debug enabled 0bx1xxxxxxx: SOP extension#1 enabled 0b1xxxxxxxx: SOP extension#2 enabled
        RXORDSETEN: u9,
        /// Transmission DMA mode enable When set, the bit enables DMA mode for transmission.
        TXDMAEN: u1,
        /// Reception DMA mode enable When set, the bit enables DMA mode for reception.
        RXDMAEN: u1,
        /// peripheral enable General enable of the peripheral. Upon disabling, the peripheral instantly quits any ongoing activity and all control bits and bitfields default to their reset values. They must be set to their desired values each time the peripheral transits from disabled to enabled state.
        UCPDEN: u1,
    }),
    /// configuration register 2
    /// offset: 0x04
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// BMC decoder Rx pre-filter enable The sampling clock is that of the receiver (that is, after pre-scaler).
        RXFILTDIS: u1,
        /// BMC decoder Rx pre-filter sampling method Number of consistent consecutive samples before confirming a new value.
        RXFILT2N3: u1,
        /// Force ClkReq clock request
        FORCECLK: u1,
        /// Wakeup from Stop mode enable Setting the bit enables the ASYNC_INT signal.
        WUPEN: u1,
        padding: u28 = 0,
    }),
    /// configuration register 3
    /// offset: 0x08
    CFGR3: mmio.Mmio(packed struct(u32) {
        /// SW trim value for Rd resistor on the CC1 line
        TRIM_CC1_RD: u4,
        reserved9: u5 = 0,
        /// SW trim value for Rp current sources on the CC1 line
        TRIM_CC1_RP: u4,
        reserved16: u3 = 0,
        /// SW trim value for Rd resistor on the CC2 line
        TRIM_CC2_RD: u4,
        reserved25: u5 = 0,
        /// SW trim value for Rp current sources on the CC2 line
        TRIM_CC2_RP: u4,
        padding: u3 = 0,
    }),
    /// control register
    /// offset: 0x0c
    CR: mmio.Mmio(packed struct(u32) {
        /// Type of Tx packet Writing the bitfield triggers the action as follows, depending on the value: Others: invalid From V1.1 of the USB PD specification, there is a counter defined for the duration of the BIST Carrier Mode 2. To quit this mode correctly (after the "tBISTContMode" delay), disable the peripheral (UCPDEN = 0).
        TXMODE: TXMODE,
        /// Command to send a Tx packet The bit is cleared by hardware as soon as the packet transmission begins or is discarded.
        TXSEND: u1,
        /// Command to send a Tx Hard Reset The bit is cleared by hardware as soon as the message transmission begins or is discarded.
        TXHRST: u1,
        /// Receiver mode Determines the mode of the receiver. When the bit is set, RXORDSET behaves normally, RXDR no longer receives bytes yet the CRC checking still proceeds as for a normal message.
        RXMODE: u1,
        /// USB Power Delivery receiver enable Both CC1 and CC2 receivers are disabled when the bit is cleared. Only the CC receiver selected via the PHYCCSEL bit is enabled when the bit is set.
        PHYRXEN: u1,
        /// CC1/CC2 line selector for USB Power Delivery signaling The selection depends on the cable orientation as discovered at attach.
        PHYCCSEL: PHYCCSEL,
        /// Analog PHY sub-mode Refer to TYPEC_VSTATE_CCx for the effect of this bitfield.
        ANASUBMODE: u2,
        /// Analog PHY operating mode The use of CC1 and CC2 depends on CCENABLE. Refer to ANAMODE, ANASUBMODE and link with TYPEC_VSTATE_CCx for the effect of this bitfield in conjunction with ANASUBMODE[1:0].
        ANAMODE: ANAMODE,
        /// CC line enable This bitfield enables CC1 and CC2 line analog PHYs (pull-ups and pull-downs) according to ANAMODE and ANASUBMODE[1:0] setting. A single line PHY can be enabled when, for example, the other line is driven by VCONN via an external VCONN switch. Enabling both PHYs is the normal usage for sink/source.
        CCENABLE: CCENABLE,
        reserved13: u1 = 0,
        /// VCONN switch enable for CC1
        CC1VCONNEN: u1,
        /// VCONN switch enable for CC2
        CC2VCONNEN: u1,
        /// Dead battery function enable The bit takes effect upon setting the USBPDstrobe bit of the SYS_CONFIG register. Dead battery function only operates if the external circuit is appropriately configured.
        DBATTEN: u1,
        /// FRS event detection enable Setting the bit enables FRS Rx event (FRSEVT) detection on the CC line selected through the PHYCCSEL bit. 0: Disable Clear the bit when the device is attached to an FRS-incapable source/sink.
        FRSRXEN: u1,
        /// FRS Tx signaling enable. Setting the bit enables FRS Tx signaling. The bit is cleared by hardware after a delay respecting the USB Power Delivery specification Revision 3.0.
        FRSTX: u1,
        /// Rdch condition drive The bit drives Rdch condition on the CC line selected through the PHYCCSEL bit (thus associated with VCONN), by remaining set during the source-only UnattachedWait.SRC state, to respect the Type-C state. Refer to "USB Type-C ECN for Source VCONN Discharge". The CCENABLE[1:0] bitfield must be set accordingly, too.
        RDCH: u1,
        reserved20: u1 = 0,
        /// CC1 Type-C detector disable The bit disables the Type-C detector on the CC1 line. When enabled, the Type-C detector for CC1 is configured through ANAMODE and ANASUBMODE[1:0].
        CC1TCDIS: u1,
        /// CC2 Type-C detector disable The bit disables the Type-C detector on the CC2 line. When enabled, the Type-C detector for CC2 is configured through ANAMODE and ANASUBMODE[1:0].
        CC2TCDIS: u1,
        padding: u10 = 0,
    }),
    /// interrupt mask register
    /// offset: 0x10
    IMR: mmio.Mmio(packed struct(u32) {
        /// TXIS interrupt enable
        TXISIE: u1,
        /// TXMSGDISC interrupt enable
        TXMSGDISCIE: u1,
        /// TXMSGSENT interrupt enable
        TXMSGSENTIE: u1,
        /// TXMSGABT interrupt enable
        TXMSGABTIE: u1,
        /// HRSTDISC interrupt enable
        HRSTDISCIE: u1,
        /// HRSTSENT interrupt enable
        HRSTSENTIE: u1,
        /// TXUND interrupt enable
        TXUNDIE: u1,
        reserved8: u1 = 0,
        /// RXNE interrupt enable
        RXNEIE: u1,
        /// RXORDDET interrupt enable
        RXORDDETIE: u1,
        /// RXHRSTDET interrupt enable
        RXHRSTDETIE: u1,
        /// RXOVR interrupt enable
        RXOVRIE: u1,
        /// RXMSGEND interrupt enable
        RXMSGENDIE: u1,
        reserved14: u1 = 0,
        /// TYPECEVT1 interrupt enable
        TYPECEVT1IE: u1,
        /// TYPECEVT2 interrupt enable
        TYPECEVT2IE: u1,
        reserved20: u4 = 0,
        /// FRSEVT interrupt enable
        FRSEVTIE: u1,
        padding: u11 = 0,
    }),
    /// status register
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Transmit interrupt status The flag indicates that the TXDR register is empty and new data write is required (as the amount of data sent has not reached the payload size defined in the TXPAYSZ bitfield). The flag is cleared with the data write into the TXDR register.
        TXIS: u1,
        /// Message transmission discarded The flag indicates that a message transmission was dropped. The flag is cleared by setting the TXMSGDISCCF bit. Transmission of a message can be dropped if there is a concurrent receive in progress or at excessive noise on the line. After a Tx message is discarded, the flag is only raised when the CC line becomes idle.
        TXMSGDISC: u1,
        /// Message transmission completed The flag indicates the completion of packet transmission. It is cleared by setting the TXMSGSENTCF bit. In the event of a message transmission interrupted by a Hard Reset, the flag is not raised.
        TXMSGSENT: u1,
        /// Transmit message abort The flag indicates that a Tx message is aborted due to a subsequent Hard Reset message send request taking priority during transmit. It is cleared by setting the TXMSGABTCF bit.
        TXMSGABT: u1,
        /// Hard Reset discarded The flag indicates that the Hard Reset message is discarded. The flag is cleared by setting the HRSTDISCCF bit.
        HRSTDISC: u1,
        /// Hard Reset message sent The flag indicates that the Hard Reset message is sent. The flag is cleared by setting the HRSTSENTCF bit.
        HRSTSENT: u1,
        /// Tx data underrun detection The flag indicates that the Tx data register (TXDR) was not written in time for a transmit message to execute normally. It is cleared by setting the TXUNDCF bit.
        TXUND: u1,
        reserved8: u1 = 0,
        /// Receive data register not empty detection The flag indicates that the RXDR register is not empty. It is automatically cleared upon reading RXDR.
        RXNE: u1,
        /// Rx ordered set (4 K-codes) detection The flag indicates the detection of an ordered set. The relevant information is stored in the RXORDSET[2:0] bitfield of the RX_ORDSET register. It is cleared by setting the RXORDDETCF bit.
        RXORDDET: u1,
        /// Rx Hard Reset receipt detection The flag indicates the receipt of valid Hard Reset message. It is cleared by setting the RXHRSTDETCF bit.
        RXHRSTDET: u1,
        /// Rx data overflow detection The flag indicates Rx data buffer overflow. It is cleared by setting the RXOVRCF bit. The buffer overflow can occur if the received data are not read fast enough.
        RXOVR: u1,
        /// Rx message received The flag indicates whether a message (except Hard Reset message) has been received, regardless the CRC value. The flag is cleared by setting the RXMSGENDCF bit. The RXERR flag set when the RXMSGEND flag goes high indicates errors in the last-received message.
        RXMSGEND: u1,
        /// Receive message error The flag indicates errors of the last Rx message declared (via RXMSGEND), such as incorrect CRC or truncated message (a line becoming static before EOP is met). It is asserted whenever the RXMSGEND flag is set.
        RXERR: u1,
        /// Type-C voltage level event on CC1 line The flag indicates a change of the TYPEC_VSTATE_CC1[1:0] bitfield value, which corresponds to a new Type-C event. It is cleared by setting the TYPECEVT2CF bit.
        TYPECEVT1: u1,
        /// Type-C voltage level event on CC2 line The flag indicates a change of the TYPEC_VSTATE_CC2[1:0] bitfield value, which corresponds to a new Type-C event. It is cleared by setting the TYPECEVT2CF bit.
        TYPECEVT2: u1,
        /// The status bitfield indicates the voltage level on the CC1 line in its steady state. The voltage variation on the CC1 line during USB PD messages due to the BMC PHY modulation does not impact the bitfield value.
        TYPEC_VSTATE_CC1: TYPEC_VSTATE_CC,
        /// CC2 line voltage level The status bitfield indicates the voltage level on the CC2 line in its steady state. The voltage variation on the CC2 line during USB PD messages due to the BMC PHY modulation does not impact the bitfield value.
        TYPEC_VSTATE_CC2: TYPEC_VSTATE_CC,
        /// FRS detection event The flag is cleared by setting the FRSEVTCF bit.
        FRSEVT: u1,
        padding: u11 = 0,
    }),
    /// interrupt clear register
    /// offset: 0x18
    ICR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Tx message discard flag (TXMSGDISC) clear Setting the bit clears the TXMSGDISC flag in the SR register.
        TXMSGDISCCF: u1,
        /// Tx message send flag (TXMSGSENT) clear Setting the bit clears the TXMSGSENT flag in the SR register.
        TXMSGSENTCF: u1,
        /// Tx message abort flag (TXMSGABT) clear Setting the bit clears the TXMSGABT flag in the SR register.
        TXMSGABTCF: u1,
        /// Hard reset discard flag (HRSTDISC) clear Setting the bit clears the HRSTDISC flag in the SR register.
        HRSTDISCCF: u1,
        /// Hard reset send flag (HRSTSENT) clear Setting the bit clears the HRSTSENT flag in the SR register.
        HRSTSENTCF: u1,
        /// Tx underflow flag (TXUND) clear Setting the bit clears the TXUND flag in the SR register.
        TXUNDCF: u1,
        reserved9: u2 = 0,
        /// Rx ordered set detect flag (RXORDDET) clear Setting the bit clears the RXORDDET flag in the SR register.
        RXORDDETCF: u1,
        /// Rx Hard Reset detect flag (RXHRSTDET) clear Setting the bit clears the RXHRSTDET flag in the SR register.
        RXHRSTDETCF: u1,
        /// Rx overflow flag (RXOVR) clear Setting the bit clears the RXOVR flag in the SR register.
        RXOVRCF: u1,
        /// Rx message received flag (RXMSGEND) clear Setting the bit clears the RXMSGEND flag in the SR register.
        RXMSGENDCF: u1,
        reserved14: u1 = 0,
        /// Type-C CC1 event flag (TYPECEVT1) clear Setting the bit clears the TYPECEVT1 flag in the SR register
        TYPECEVT1CF: u1,
        /// Type-C CC2 line event flag (TYPECEVT2) clear Setting the bit clears the TYPECEVT2 flag in the SR register
        TYPECEVT2CF: u1,
        reserved20: u4 = 0,
        /// FRS event flag (FRSEVT) clear Setting the bit clears the FRSEVT flag in the SR register.
        FRSEVTCF: u1,
        padding: u11 = 0,
    }),
    /// Tx ordered set type register
    /// offset: 0x1c
    TX_ORDSETR: mmio.Mmio(packed struct(u32) {
        /// Ordered set to transmit The bitfield determines a full 20-bit sequence to transmit, consisting of four K-codes, each of five bits, defining the packet to transmit. The bit 0 (bit 0 of K-code1) is the first, the bit 19 (bit 4 of K‑code4) the last.
        TXORDSET: u20,
        padding: u12 = 0,
    }),
    /// Tx payload size register
    /// offset: 0x20
    TX_PAYSZR: mmio.Mmio(packed struct(u32) {
        /// Payload size yet to transmit The bitfield is modified by software and by hardware. It contains the number of bytes of a payload (including header but excluding CRC) yet to transmit: each time a data byte is written into the TXDR register, the bitfield value decrements and the TXIS bit is set, except when the bitfield value reaches zero. The enumerated values are standard payload sizes before the start of transmission.
        TXPAYSZ: u10,
        padding: u22 = 0,
    }),
    /// Tx data register
    /// offset: 0x24
    TXDR: mmio.Mmio(packed struct(u32) {
        /// Data byte to transmit
        TXDATA: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    RX_ORDSETR: mmio.Mmio(packed struct(u32) {
        /// Rx ordered set code detected
        RXORDSET: RXORDSET,
        /// The bit indicates the number of correct K‑codes. For debug purposes only.
        RXSOP3OF4: u1,
        /// The bitfield is for debug purposes only. Others: Invalid
        RXSOPKINVALID: RXSOPKINVALID,
        padding: u25 = 0,
    }),
    /// offset: 0x2c
    RX_PAYSZR: mmio.Mmio(packed struct(u32) {
        /// Rx payload size received This bitfield contains the number of bytes of a payload (including header but excluding CRC) received: each time a new data byte is received in the RXDR register, the bitfield value increments and the RXMSGEND flag is set (and an interrupt generated if enabled). The bitfield may return a spurious value when a byte reception is ongoing (the RXMSGEND flag is low).
        RXPAYSZ: u10,
        padding: u22 = 0,
    }),
    /// offset: 0x30
    RXDR: mmio.Mmio(packed struct(u32) {
        /// Data byte received
        RXDATA: u8,
        padding: u24 = 0,
    }),
    /// Rx ordered set extension register 1
    /// offset: 0x34
    RX_ORDEXTR1: mmio.Mmio(packed struct(u32) {
        /// Ordered set 1 received The bitfield contains a full 20-bit sequence received, consisting of four K‑codes, each of five bits. The bit 0 (bit 0 of K‑code1) is receive first, the bit 19 (bit 4 of K‑code4) last.
        RXSOPX1: u20,
        padding: u12 = 0,
    }),
    /// Rx ordered set extension register 2
    /// offset: 0x38
    RX_ORDEXTR2: mmio.Mmio(packed struct(u32) {
        /// Ordered set 2 received The bitfield contains a full 20-bit sequence received, consisting of four K‑codes, each of five bits. The bit 0 (bit 0 of K‑code1) is receive first, the bit 19 (bit 4 of K‑code4) last.
        RXSOPX2: u20,
        padding: u12 = 0,
    }),
    /// offset: 0x3c
    reserved60: [952]u8,
    /// UCPD IP ID register
    /// offset: 0x3f4
    IPVER: mmio.Mmio(packed struct(u32) {
        /// IPVER
        IPVER: u32,
    }),
    /// UCPD IP ID register
    /// offset: 0x3f8
    IPID: mmio.Mmio(packed struct(u32) {
        /// IPID
        IPID: u32,
    }),
    /// UCPD IP ID register
    /// offset: 0x3fc
    MID: mmio.Mmio(packed struct(u32) {
        /// IPID
        IPID: u32,
    }),
};
