const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// IPCC
pub const IPCC = extern struct {
    /// CPU specific registers
    /// offset: 0x00
    CPU: u32,
};

/// IPCC
pub const IPCC_CPU = extern struct {
    /// Control register CPUx
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// processor x Receive channel occupied interrupt enable
        RXOIE: u1,
        reserved16: u15 = 0,
        /// processor x Transmit channel free interrupt enable
        TXFIE: u1,
        padding: u15 = 0,
    }),
    /// Mask register CPUx
    /// offset: 0x04
    MR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[0]": u1,
        /// (2/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[1]": u1,
        /// (3/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[2]": u1,
        /// (4/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[3]": u1,
        /// (5/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[4]": u1,
        /// (6/6 of CHOM) processor x Receive channel y occupied interrupt enable
        @"CHOM[5]": u1,
        reserved16: u10 = 0,
        /// (1/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[0]": u1,
        /// (2/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[1]": u1,
        /// (3/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[2]": u1,
        /// (4/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[3]": u1,
        /// (5/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[4]": u1,
        /// (6/6 of CHFM) processor x Transmit channel y free interrupt mask
        @"CHFM[5]": u1,
        padding: u10 = 0,
    }),
    /// Status Set or Clear register CPUx
    /// offset: 0x08
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CHC) processor x Receive channel y status clear
        @"CHC[0]": u1,
        /// (2/6 of CHC) processor x Receive channel y status clear
        @"CHC[1]": u1,
        /// (3/6 of CHC) processor x Receive channel y status clear
        @"CHC[2]": u1,
        /// (4/6 of CHC) processor x Receive channel y status clear
        @"CHC[3]": u1,
        /// (5/6 of CHC) processor x Receive channel y status clear
        @"CHC[4]": u1,
        /// (6/6 of CHC) processor x Receive channel y status clear
        @"CHC[5]": u1,
        reserved16: u10 = 0,
        /// (1/6 of CHS) processor x Transmit channel y status set
        @"CHS[0]": u1,
        /// (2/6 of CHS) processor x Transmit channel y status set
        @"CHS[1]": u1,
        /// (3/6 of CHS) processor x Transmit channel y status set
        @"CHS[2]": u1,
        /// (4/6 of CHS) processor x Transmit channel y status set
        @"CHS[3]": u1,
        /// (5/6 of CHS) processor x Transmit channel y status set
        @"CHS[4]": u1,
        /// (6/6 of CHS) processor x Transmit channel y status set
        @"CHS[5]": u1,
        padding: u10 = 0,
    }),
    /// CPUx to CPUy status register
    /// offset: 0x0c
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[0]": u1,
        /// (2/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[1]": u1,
        /// (3/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[2]": u1,
        /// (4/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[3]": u1,
        /// (5/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[4]": u1,
        /// (6/6 of CHF) processor x transmit to process y Receive channel z status flag
        @"CHF[5]": u1,
        padding: u26 = 0,
    }),
};
