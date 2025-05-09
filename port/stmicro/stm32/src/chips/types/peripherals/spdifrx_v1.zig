const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Receiver Interface
pub const SPDIFRX = extern struct {
    /// Control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Peripheral Block Enable
        SPDIFEN: u2,
        /// Receiver DMA ENable for data flow
        RXDMAEN: u1,
        /// STerEO Mode
        RXSTEO: u1,
        /// RX Data format
        DRFMT: u2,
        /// Mask Parity error bit
        PMSK: u1,
        /// Mask of Validity bit
        VMSK: u1,
        /// Mask of channel status and user bits
        CUMSK: u1,
        /// Mask of Preamble Type bits
        PTMSK: u1,
        /// Control Buffer DMA ENable for control flow
        CBDMAEN: u1,
        /// Channel Selection
        CHSEL: u1,
        /// Maximum allowed re-tries during synchronization phase
        NBTR: u2,
        /// Wait For Activity
        WFA: u1,
        reserved16: u1 = 0,
        /// input selection
        INSEL: u3,
        padding: u13 = 0,
    }),
    /// Interrupt mask register
    /// offset: 0x04
    IMR: mmio.Mmio(packed struct(u32) {
        /// RXNE interrupt enable
        RXNEIE: u1,
        /// Control Buffer Ready Interrupt Enable
        CSRNEIE: u1,
        /// Parity error interrupt enable
        PERRIE: u1,
        /// Overrun error Interrupt Enable
        OVRIE: u1,
        /// Synchronization Block Detected Interrupt Enable
        SBLKIE: u1,
        /// Synchronization Done
        SYNCDIE: u1,
        /// Serial Interface Error Interrupt Enable
        IFEIE: u1,
        padding: u25 = 0,
    }),
    /// Status register
    /// offset: 0x08
    SR: mmio.Mmio(packed struct(u32) {
        /// Read data register not empty
        RXNE: u1,
        /// Control Buffer register is not empty
        CSRNE: u1,
        /// Parity error
        PERR: u1,
        /// Overrun error
        OVR: u1,
        /// Synchronization Block Detected
        SBD: u1,
        /// Synchronization Done
        SYNCD: u1,
        /// Framing error
        FERR: u1,
        /// Synchronization error
        SERR: u1,
        /// Time-out error
        TERR: u1,
        reserved16: u7 = 0,
        /// Duration of 5 symbols counted with SPDIF_CLK
        WIDTH: u15,
        padding: u1 = 0,
    }),
    /// Interrupt Flag Clear register
    /// offset: 0x0c
    IFCR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// Clears the Parity error flag
        PERRCF: u1,
        /// Clears the Overrun error flag
        OVRCF: u1,
        /// Clears the Synchronization Block Detected flag
        SBDCF: u1,
        /// Clears the Synchronization Done flag
        SYNCDCF: u1,
        padding: u26 = 0,
    }),
    /// Data input register
    /// offset: 0x10
    DR: mmio.Mmio(packed struct(u32) {
        /// Parity Error bit
        DR: u24,
        /// Parity Error bit
        PE: u1,
        /// Validity bit
        V: u1,
        /// User bit
        U: u1,
        /// Channel Status bit
        C: u1,
        /// Preamble Type
        PT: u2,
        padding: u2 = 0,
    }),
    /// Channel Status register
    /// offset: 0x14
    CSR: mmio.Mmio(packed struct(u32) {
        /// User data information
        USR: u16,
        /// Channel A status information
        CS: u8,
        /// Start Of Block
        SOB: u1,
        padding: u7 = 0,
    }),
    /// Debug Information register
    /// offset: 0x18
    DIR: mmio.Mmio(packed struct(u32) {
        /// Threshold HIGH
        THI: u13,
        reserved16: u3 = 0,
        /// Threshold LOW
        TLO: u13,
        padding: u3 = 0,
    }),
};
