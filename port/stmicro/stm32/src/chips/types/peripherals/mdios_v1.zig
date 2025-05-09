const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Management data input/output slave
pub const MDIOS = extern struct {
    /// MDIOS configuration register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Peripheral enable
        EN: u1,
        /// Register write interrupt enable
        WRIE: u1,
        /// Register Read Interrupt Enable
        RDIE: u1,
        /// Error interrupt enable
        EIE: u1,
        reserved7: u3 = 0,
        /// Disable Preamble Check
        DPC: u1,
        /// Slaves's address
        PORT_ADDRESS: u5,
        padding: u19 = 0,
    }),
    /// MDIOS write flag register
    /// offset: 0x04
    WRFR: mmio.Mmio(packed struct(u32) {
        /// Write flags for MDIO registers 0 to 31
        WRF: u32,
    }),
    /// MDIOS clear write flag register
    /// offset: 0x08
    CWRFR: mmio.Mmio(packed struct(u32) {
        /// Clear the write flag
        CWRF: u32,
    }),
    /// MDIOS read flag register
    /// offset: 0x0c
    RDFR: mmio.Mmio(packed struct(u32) {
        /// Read flags for MDIO registers 0 to 31
        RDF: u32,
    }),
    /// MDIOS clear read flag register
    /// offset: 0x10
    CRDFR: mmio.Mmio(packed struct(u32) {
        /// Clear the read flag
        CRDF: u32,
    }),
    /// MDIOS status register
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Preamble error flag
        PERF: u1,
        /// Start error flag
        SERF: u1,
        /// Turnaround error flag
        TERF: u1,
        padding: u29 = 0,
    }),
    /// MDIOS clear flag register
    /// offset: 0x18
    CLRFR: mmio.Mmio(packed struct(u32) {
        /// Clear the preamble error flag
        CPERF: u1,
        /// Clear the start error flag
        CSERF: u1,
        /// Clear the turnaround error flag
        CTERF: u1,
        padding: u29 = 0,
    }),
    /// offset: 0x1c
    reserved28: [228]u8,
    /// MDIOS input data register %s
    /// offset: 0x100
    DINR: [32]mmio.Mmio(packed struct(u32) {
        /// Input data received from MDIO Master during write frames
        DIN: u16,
        padding: u16 = 0,
    }),
    /// MDIOS output data register %s
    /// offset: 0x180
    DOUTR: [32]mmio.Mmio(packed struct(u32) {
        /// Output data sent to MDIO Master during read frames
        DOUT: u16,
        padding: u16 = 0,
    }),
};
