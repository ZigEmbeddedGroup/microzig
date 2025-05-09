const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const DIR = enum(u1) {
    /// data transmitted by the USB peripheral to the host PC
    To = 0x0,
    /// data received by the USB peripheral from the host PC
    From = 0x1,
};

pub const EP_TYPE = enum(u2) {
    /// Bulk endpoint
    Bulk = 0x0,
    /// Control endpoint
    Control = 0x1,
    /// Iso endpoint
    Iso = 0x2,
    /// Interrupt endpoint
    Interrupt = 0x3,
};

pub const STAT = enum(u2) {
    /// all requests addressed to this endpoint are ignored
    Disabled = 0x0,
    /// the endpoint is stalled and all requests result in a STALL handshake
    Stall = 0x1,
    /// the endpoint is naked and all requests result in a NAK handshake
    Nak = 0x2,
    /// this endpoint is enabled, requests are ACKed
    Valid = 0x3,
};

/// Universal serial bus full-speed device interface
pub const USB = extern struct {
    /// endpoint register
    /// offset: 0x00
    EPR: [8]mmio.Mmio(packed struct(u32) {
        /// EA
        EA: u4,
        /// STAT_TX
        STAT_TX: STAT,
        /// DTOG_TX
        DTOG_TX: u1,
        /// CTR_TX
        CTR_TX: u1,
        /// EP_KIND
        EP_KIND: u1,
        /// EPTYPE
        EP_TYPE: EP_TYPE,
        /// SETUP
        SETUP: u1,
        /// STAT_RX
        STAT_RX: STAT,
        /// DTOG_RX
        DTOG_RX: u1,
        /// CTR_RX
        CTR_RX: u1,
        padding: u16 = 0,
    }),
    /// offset: 0x20
    reserved32: [32]u8,
    /// control register
    /// offset: 0x40
    CNTR: mmio.Mmio(packed struct(u32) {
        /// Force a reset of the USB peripheral, exactly like a RESET signaling on the USB
        FRES: u1,
        /// Enter power down mode
        PDWN: u1,
        /// Enter low-power mode
        LPMODE: u1,
        /// Enter suspend mode. Clocks and static power dissipation in the analog transceiver are left unaffected
        FSUSP: u1,
        /// Resume request
        RESUME: u1,
        reserved8: u3 = 0,
        /// ESOF Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        ESOFM: u1,
        /// SOF Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        SOFM: u1,
        /// RESET Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        RESETM: u1,
        /// SUSP Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        SUSPM: u1,
        /// WKUP Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        WKUPM: u1,
        /// ERR Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        ERRM: u1,
        /// PMAOVR Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        PMAOVRM: u1,
        /// CTR Interrupt enabled, an interrupt request is generated when the corresponding bit in the USB_ISTR register is set
        CTRM: u1,
        padding: u16 = 0,
    }),
    /// interrupt status register
    /// offset: 0x44
    ISTR: mmio.Mmio(packed struct(u32) {
        /// EP_ID
        EP_ID: u4,
        /// DIR
        DIR: DIR,
        reserved8: u3 = 0,
        /// an SOF packet is expected but not received
        ESOF: u1,
        /// beginning of a new USB frame and it is set when a SOF packet arrives through the USB bus
        SOF: u1,
        /// peripheral detects an active USB RESET signal at its inputs
        RESET: u1,
        /// no traffic has been received for 3 ms, indicating a suspend mode request from the USB bus
        SUSP: u1,
        /// activity is detected that wakes up the USB peripheral
        WKUP: u1,
        /// One of No ANSwer, Cyclic Redundancy Check, Bit Stuffing or Framing format Violation error occurred
        ERR: u1,
        /// microcontroller has not been able to respond in time to an USB memory request
        PMAOVR: u1,
        /// endpoint has successfully completed a transaction
        CTR: u1,
        padding: u16 = 0,
    }),
    /// frame number register
    /// offset: 0x48
    FNR: mmio.Mmio(packed struct(u32) {
        /// FN
        FN: u11,
        /// LSOF
        LSOF: u2,
        /// the frame timer remains in this state until an USB reset or USB suspend event occurs
        LCK: u1,
        /// received data minus upstream port data line
        RXDM: u1,
        /// received data plus upstream port data line
        RXDP: u1,
        padding: u16 = 0,
    }),
    /// device address
    /// offset: 0x4c
    DADDR: mmio.Mmio(packed struct(u32) {
        /// device address
        ADD: u7,
        /// USB device enabled
        EF: u1,
        padding: u24 = 0,
    }),
    /// Buffer table address
    /// offset: 0x50
    BTABLE: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// BTABLE
        BTABLE: u13,
        padding: u16 = 0,
    }),
};
