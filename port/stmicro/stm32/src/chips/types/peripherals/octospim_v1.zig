const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// OctoSPI IO Manager
pub const OCTOSPIM = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Multiplexed mode enable
        MUXEN: u1,
        reserved16: u15 = 0,
        /// REQ to ACK time
        REQ2ACK_TIME: u8,
        padding: u8 = 0,
    }),
    /// OctoSPI IO Manager Port 1 Configuration Register
    /// offset: 0x04
    P1CR: mmio.Mmio(packed struct(u32) {
        /// CLK/CLK Enable for Port
        CLKEN: u1,
        /// CLK/CLK Source for Port
        CLKSRC: u1,
        reserved4: u2 = 0,
        /// DQS Enable for Port
        DQSEN: u1,
        /// DQS Source for Port
        DQSSRC: u1,
        reserved8: u2 = 0,
        /// CS Enable for Port
        NCSEN: u1,
        /// CS Source for Port
        NCSSRC: u1,
        reserved16: u6 = 0,
        /// Enable for Port
        IOLEN: u1,
        /// Source for Port
        IOLSRC: u2,
        reserved24: u5 = 0,
        /// Enable for Port n
        IOHEN: u1,
        /// Source for Port
        IOHSRC: u2,
        padding: u5 = 0,
    }),
    /// OctoSPI IO Manager Port 2 Configuration Register
    /// offset: 0x08
    P2CR: mmio.Mmio(packed struct(u32) {
        /// CLK/CLK Enable for Port
        CLKEN: u1,
        /// CLK/CLK Source for Port
        CLKSRC: u1,
        reserved4: u2 = 0,
        /// DQS Enable for Port
        DQSEN: u1,
        /// DQS Source for Port
        DQSSRC: u1,
        reserved8: u2 = 0,
        /// CS Enable for Port
        NCSEN: u1,
        /// CS Source for Port
        NCSSRC: u1,
        reserved16: u6 = 0,
        /// Enable for Port
        IOLEN: u1,
        /// Source for Port
        IOLSRC: u2,
        reserved24: u5 = 0,
        /// Enable for Port n
        IOHEN: u1,
        /// Source for Port
        IOHSRC: u2,
        padding: u5 = 0,
    }),
};
