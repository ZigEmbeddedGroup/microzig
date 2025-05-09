const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// HDMI-CEC controller.
pub const CEC = extern struct {
    /// configuration register.
    /// offset: 0x00
    CFGR: mmio.Mmio(packed struct(u32) {
        /// Peripheral enable.
        PE: u1,
        /// Interrupt enable.
        IE: u1,
        /// Bit timing error mode.
        BTEM: u1,
        /// Bit period error mode.
        BPEM: u1,
        padding: u28 = 0,
    }),
    /// CEC own address register.
    /// offset: 0x04
    OAR: mmio.Mmio(packed struct(u32) {
        /// Own address.
        OA: u4,
        padding: u28 = 0,
    }),
    /// Rx Data Register.
    /// offset: 0x08
    PRES: mmio.Mmio(packed struct(u32) {
        /// CEC Rx Data Register.
        PRESC: u14,
        padding: u18 = 0,
    }),
    /// CEC error status register.
    /// offset: 0x0c
    ESR: mmio.Mmio(packed struct(u32) {
        /// Bit timing error.
        BTE: u1,
        /// Bit period error.
        BPE: u1,
        /// Rx block transfer finished error.
        RBTFE: u1,
        /// Start bit error.
        SBE: u1,
        /// Block acknowledge error.
        ACKE: u1,
        /// Line error.
        LINE: u1,
        /// Tx block transfer finished error.
        TBTFE: u1,
        padding: u25 = 0,
    }),
    /// CEC control and status register.
    /// offset: 0x10
    CSR: mmio.Mmio(packed struct(u32) {
        /// Tx start of message.
        TSOM: u1,
        /// Tx end of message.
        TEOM: u1,
        /// Tx error.
        TERR: u1,
        /// Tx byte transfer request or block transfer finished.
        TBTRF: u1,
        /// Rx start of message.
        RSOM: u1,
        /// Rx end of message.
        REOM: u1,
        /// Rx error.
        RERR: u1,
        /// Rx byte/block transfer finished.
        RBTF: u1,
        padding: u24 = 0,
    }),
    /// CEC Tx data register.
    /// offset: 0x14
    TXD: mmio.Mmio(packed struct(u32) {
        /// Tx Data register.
        TXD: u8,
        padding: u24 = 0,
    }),
    /// CEC Rx data register.
    /// offset: 0x18
    RXD: mmio.Mmio(packed struct(u32) {
        /// Rx data.
        RXD: u8,
        padding: u24 = 0,
    }),
};
