const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CKPOL = enum(u1) {
    /// Falling edge active for inputs or rising edge active for outputs.
    FallingEdge = 0x0,
    /// Rising edge active for inputs or falling edge active for outputs.
    RisingEdge = 0x1,
};

pub const DEPOL = enum(u1) {
    /// PSSI_DE active low (0 indicates that data is valid).
    ActiveLow = 0x0,
    /// PSSI_DE active high (1 indicates that data is valid).
    ActiveHigh = 0x1,
};

pub const DERDYCFG = enum(u3) {
    /// PSSI_DE and PSSI_RDY both disabled.
    Disabled = 0x0,
    /// Only PSSI_RDY enabled.
    Rdy = 0x1,
    /// Only PSSI_DE enabled.
    De = 0x2,
    /// Both PSSI_RDY and PSSI_DE alternate functions enabled.
    RdyDeAlt = 0x3,
    /// Both PSSI_RDY and PSSI_DE features enabled - bidirectional on PSSI_RDY pin.
    RdyDe = 0x4,
    /// Only PSSI_RDY function enabled, but mapped to PSSI_DE pin.
    RdyRemapped = 0x5,
    /// Only PSSI_DE function enabled, but mapped to PSSI_RDY pin.
    DeRemapped = 0x6,
    /// Both PSSI_RDY and PSSI_DE features enabled - bidirectional on PSSI_DE pin.
    RdyDeBidi = 0x7,
};

pub const EDM = enum(u2) {
    /// Interface captures 8-bit data on every parallel data clock.
    BitWidth8 = 0x0,
    /// The interface captures 16-bit data on every parallel data clock.
    BitWidth16 = 0x3,
    _,
};

pub const OUTEN = enum(u1) {
    /// Data is input synchronously with PSSI_PDCK.
    ReceiveMode = 0x0,
    /// Data is output synchronously with PSSI_PDCK.
    TransmitMode = 0x1,
};

pub const RDYPOL = enum(u1) {
    /// PSSI_RDY active low (0 indicates that the receiver is ready to receive).
    ActiveLow = 0x0,
    /// PSSI_RDY active high (1 indicates that the receiver is ready to receive).
    ActiveHigh = 0x1,
};

/// Parallel synchronous slave interface.
pub const PSSI = extern struct {
    /// PSSI control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        reserved5: u5 = 0,
        /// Parallel data clock polarity This bit configures the capture edge of the parallel clock or the edge used for driving outputs, depending on OUTEN.
        CKPOL: CKPOL,
        /// Data enable (PSSI_DE) polarity This bit indicates the level on the PSSI_DE pin when the data are not valid on the parallel interface.
        DEPOL: DEPOL,
        reserved8: u1 = 0,
        /// Ready (PSSI_RDY) polarity This bit indicates the level on the PSSI_RDY pin when the data are not valid on the parallel interface.
        RDYPOL: RDYPOL,
        reserved10: u1 = 0,
        /// Extended data mode.
        EDM: EDM,
        reserved14: u2 = 0,
        /// PSSI enable The contents of the FIFO are flushed when ENABLE is cleared to 0. Note: When ENABLE=1, the content of PSSI_CR must not be changed, except for the ENABLE bit itself. All configuration bits can change as soon as ENABLE changes from 0 to 1. The DMA controller and all PSSI configuration registers must be programmed correctly before setting the ENABLE bit to 1. The ENABLE bit and the DCMI ENABLE bit (bit 15 of DCMI_CR) must not be set to 1 at the same time.
        ENABLE: u1,
        reserved18: u3 = 0,
        /// Data enable and ready configuration When the PSSI_RDY function is mapped to the PSSI_DE pin (settings 101 or 111), it is still the RDYPOL bit which determines its polarity. Similarly, when the PSSI_DE function is mapped to the PSSI_RDY pin (settings 110 or 111), it is still the DEPOL bit which determines its polarity.
        DERDYCFG: DERDYCFG,
        reserved30: u9 = 0,
        /// DMA enable bit.
        DMAEN: u1,
        /// Data direction selection bit.
        OUTEN: OUTEN,
    }),
    /// PSSI status register.
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// FIFO is ready to transfer four bytes.
        RTT4B: u1,
        /// FIFO is ready to transfer one byte.
        RTT1B: u1,
        padding: u28 = 0,
    }),
    /// PSSI raw interrupt status register.
    /// offset: 0x08
    RIS: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Data buffer overrun/underrun raw interrupt status This bit is cleared by writing a 1 to the OVR_ISC bit in PSSI_ICR.
        OVR_RIS: u1,
        padding: u30 = 0,
    }),
    /// PSSI interrupt enable register.
    /// offset: 0x0c
    IER: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Data buffer overrun/underrun interrupt enable.
        OVR_IE: u1,
        padding: u30 = 0,
    }),
    /// PSSI masked interrupt status register.
    /// offset: 0x10
    MIS: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Data buffer overrun/underrun masked interrupt status This bit is set to 1 only when PSSI_IER/OVR_IE and PSSI_RIS/OVR_RIS are both set to 1.
        OVR_MIS: u1,
        padding: u30 = 0,
    }),
    /// PSSI interrupt clear register.
    /// offset: 0x14
    ICR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Data buffer overrun/underrun interrupt status clear Writing this bit to 1 clears the OVR_RIS bit in PSSI_RIS.
        OVR_ISC: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x18
    reserved24: [16]u8,
    /// PSSI data register.
    /// offset: 0x28
    DR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of BYTE) Data byte 0.
        @"BYTE[0]": u8,
        /// (2/4 of BYTE) Data byte 0.
        @"BYTE[1]": u8,
        /// (3/4 of BYTE) Data byte 0.
        @"BYTE[2]": u8,
        /// (4/4 of BYTE) Data byte 0.
        @"BYTE[3]": u8,
    }),
};
