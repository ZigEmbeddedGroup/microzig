const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Touch sensing controller.
pub const TSC = extern struct {
    /// control register.
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Touch sensing controller enable.
        TSCE: u1,
        /// Start a new acquisition.
        START: u1,
        /// Acquisition mode.
        AM: u1,
        /// Synchronization pin polarity.
        SYNCPOL: u1,
        /// I/O Default mode.
        IODEF: u1,
        /// Max count value.
        MCV: u3,
        reserved12: u4 = 0,
        /// pulse generator prescaler.
        PGPSC: u3,
        /// Spread spectrum prescaler.
        SSPSC: u1,
        /// Spread spectrum enable.
        SSE: u1,
        /// Spread spectrum deviation.
        SSD: u7,
        /// Charge transfer pulse low.
        CTPL: u4,
        /// Charge transfer pulse high.
        CTPH: u4,
    }),
    /// interrupt enable register.
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// End of acquisition interrupt enable.
        EOAIE: u1,
        /// Max count error interrupt enable.
        MCEIE: u1,
        padding: u30 = 0,
    }),
    /// interrupt clear register.
    /// offset: 0x08
    ICR: mmio.Mmio(packed struct(u32) {
        /// End of acquisition interrupt clear.
        EOAIC: u1,
        /// Max count error interrupt clear.
        MCEIC: u1,
        padding: u30 = 0,
    }),
    /// interrupt status register.
    /// offset: 0x0c
    ISR: mmio.Mmio(packed struct(u32) {
        /// End of acquisition flag.
        EOAF: u1,
        /// Max count error flag.
        MCEF: u1,
        padding: u30 = 0,
    }),
    /// I/O hysteresis control register.
    /// offset: 0x10
    IOHCR: mmio.Mmio(packed struct(u32) {
        /// G1_IO1 Schmitt trigger hysteresis mode.
        G1_IO1: u1,
        /// G1_IO2 Schmitt trigger hysteresis mode.
        G1_IO2: u1,
        /// G1_IO3 Schmitt trigger hysteresis mode.
        G1_IO3: u1,
        /// G1_IO4 Schmitt trigger hysteresis mode.
        G1_IO4: u1,
        /// G2_IO1 Schmitt trigger hysteresis mode.
        G2_IO1: u1,
        /// G2_IO2 Schmitt trigger hysteresis mode.
        G2_IO2: u1,
        /// G2_IO3 Schmitt trigger hysteresis mode.
        G2_IO3: u1,
        /// G2_IO4 Schmitt trigger hysteresis mode.
        G2_IO4: u1,
        /// G3_IO1 Schmitt trigger hysteresis mode.
        G3_IO1: u1,
        /// G3_IO2 Schmitt trigger hysteresis mode.
        G3_IO2: u1,
        /// G3_IO3 Schmitt trigger hysteresis mode.
        G3_IO3: u1,
        /// G3_IO4 Schmitt trigger hysteresis mode.
        G3_IO4: u1,
        /// G4_IO1 Schmitt trigger hysteresis mode.
        G4_IO1: u1,
        /// G4_IO2 Schmitt trigger hysteresis mode.
        G4_IO2: u1,
        /// G4_IO3 Schmitt trigger hysteresis mode.
        G4_IO3: u1,
        /// G4_IO4 Schmitt trigger hysteresis mode.
        G4_IO4: u1,
        /// G5_IO1 Schmitt trigger hysteresis mode.
        G5_IO1: u1,
        /// G5_IO2 Schmitt trigger hysteresis mode.
        G5_IO2: u1,
        /// G5_IO3 Schmitt trigger hysteresis mode.
        G5_IO3: u1,
        /// G5_IO4 Schmitt trigger hysteresis mode.
        G5_IO4: u1,
        /// G6_IO1 Schmitt trigger hysteresis mode.
        G6_IO1: u1,
        /// G6_IO2 Schmitt trigger hysteresis mode.
        G6_IO2: u1,
        /// G6_IO3 Schmitt trigger hysteresis mode.
        G6_IO3: u1,
        /// G6_IO4 Schmitt trigger hysteresis mode.
        G6_IO4: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x14
    reserved20: [4]u8,
    /// I/O analog switch control register.
    /// offset: 0x18
    IOASCR: mmio.Mmio(packed struct(u32) {
        /// G1_IO1 analog switch enable.
        G1_IO1: u1,
        /// G1_IO2 analog switch enable.
        G1_IO2: u1,
        /// G1_IO3 analog switch enable.
        G1_IO3: u1,
        /// G1_IO4 analog switch enable.
        G1_IO4: u1,
        /// G2_IO1 analog switch enable.
        G2_IO1: u1,
        /// G2_IO2 analog switch enable.
        G2_IO2: u1,
        /// G2_IO3 analog switch enable.
        G2_IO3: u1,
        /// G2_IO4 analog switch enable.
        G2_IO4: u1,
        /// G3_IO1 analog switch enable.
        G3_IO1: u1,
        /// G3_IO2 analog switch enable.
        G3_IO2: u1,
        /// G3_IO3 analog switch enable.
        G3_IO3: u1,
        /// G3_IO4 analog switch enable.
        G3_IO4: u1,
        /// G4_IO1 analog switch enable.
        G4_IO1: u1,
        /// G4_IO2 analog switch enable.
        G4_IO2: u1,
        /// G4_IO3 analog switch enable.
        G4_IO3: u1,
        /// G4_IO4 analog switch enable.
        G4_IO4: u1,
        /// G5_IO1 analog switch enable.
        G5_IO1: u1,
        /// G5_IO2 analog switch enable.
        G5_IO2: u1,
        /// G5_IO3 analog switch enable.
        G5_IO3: u1,
        /// G5_IO4 analog switch enable.
        G5_IO4: u1,
        /// G6_IO1 analog switch enable.
        G6_IO1: u1,
        /// G6_IO2 analog switch enable.
        G6_IO2: u1,
        /// G6_IO3 analog switch enable.
        G6_IO3: u1,
        /// G6_IO4 analog switch enable.
        G6_IO4: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// I/O sampling control register.
    /// offset: 0x20
    IOSCR: mmio.Mmio(packed struct(u32) {
        /// G1_IO1 sampling mode.
        G1_IO1: u1,
        /// G1_IO2 sampling mode.
        G1_IO2: u1,
        /// G1_IO3 sampling mode.
        G1_IO3: u1,
        /// G1_IO4 sampling mode.
        G1_IO4: u1,
        /// G2_IO1 sampling mode.
        G2_IO1: u1,
        /// G2_IO2 sampling mode.
        G2_IO2: u1,
        /// G2_IO3 sampling mode.
        G2_IO3: u1,
        /// G2_IO4 sampling mode.
        G2_IO4: u1,
        /// G3_IO1 sampling mode.
        G3_IO1: u1,
        /// G3_IO2 sampling mode.
        G3_IO2: u1,
        /// G3_IO3 sampling mode.
        G3_IO3: u1,
        /// G3_IO4 sampling mode.
        G3_IO4: u1,
        /// G4_IO1 sampling mode.
        G4_IO1: u1,
        /// G4_IO2 sampling mode.
        G4_IO2: u1,
        /// G4_IO3 sampling mode.
        G4_IO3: u1,
        /// G4_IO4 sampling mode.
        G4_IO4: u1,
        /// G5_IO1 sampling mode.
        G5_IO1: u1,
        /// G5_IO2 sampling mode.
        G5_IO2: u1,
        /// G5_IO3 sampling mode.
        G5_IO3: u1,
        /// G5_IO4 sampling mode.
        G5_IO4: u1,
        /// G6_IO1 sampling mode.
        G6_IO1: u1,
        /// G6_IO2 sampling mode.
        G6_IO2: u1,
        /// G6_IO3 sampling mode.
        G6_IO3: u1,
        /// G6_IO4 sampling mode.
        G6_IO4: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x24
    reserved36: [4]u8,
    /// I/O channel control register.
    /// offset: 0x28
    IOCCR: mmio.Mmio(packed struct(u32) {
        /// G1_IO1 channel mode.
        G1_IO1: u1,
        /// G1_IO2 channel mode.
        G1_IO2: u1,
        /// G1_IO3 channel mode.
        G1_IO3: u1,
        /// G1_IO4 channel mode.
        G1_IO4: u1,
        /// G2_IO1 channel mode.
        G2_IO1: u1,
        /// G2_IO2 channel mode.
        G2_IO2: u1,
        /// G2_IO3 channel mode.
        G2_IO3: u1,
        /// G2_IO4 channel mode.
        G2_IO4: u1,
        /// G3_IO1 channel mode.
        G3_IO1: u1,
        /// G3_IO2 channel mode.
        G3_IO2: u1,
        /// G3_IO3 channel mode.
        G3_IO3: u1,
        /// G3_IO4 channel mode.
        G3_IO4: u1,
        /// G4_IO1 channel mode.
        G4_IO1: u1,
        /// G4_IO2 channel mode.
        G4_IO2: u1,
        /// G4_IO3 channel mode.
        G4_IO3: u1,
        /// G4_IO4 channel mode.
        G4_IO4: u1,
        /// G5_IO1 channel mode.
        G5_IO1: u1,
        /// G5_IO2 channel mode.
        G5_IO2: u1,
        /// G5_IO3 channel mode.
        G5_IO3: u1,
        /// G5_IO4 channel mode.
        G5_IO4: u1,
        /// G6_IO1 channel mode.
        G6_IO1: u1,
        /// G6_IO2 channel mode.
        G6_IO2: u1,
        /// G6_IO3 channel mode.
        G6_IO3: u1,
        /// G6_IO4 channel mode.
        G6_IO4: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// I/O group control status register.
    /// offset: 0x30
    IOGCSR: mmio.Mmio(packed struct(u32) {
        /// Analog I/O group x enable.
        G1E: u1,
        /// Analog I/O group x enable.
        G2E: u1,
        /// Analog I/O group x enable.
        G3E: u1,
        /// Analog I/O group x enable.
        G4E: u1,
        /// Analog I/O group x enable.
        G5E: u1,
        /// Analog I/O group x enable.
        G6E: u1,
        /// Analog I/O group x enable.
        G7E: u1,
        /// Analog I/O group x enable.
        G8E: u1,
        reserved16: u8 = 0,
        /// Analog I/O group x status.
        G1S: u1,
        /// Analog I/O group x status.
        G2S: u1,
        /// Analog I/O group x status.
        G3S: u1,
        /// Analog I/O group x status.
        G4S: u1,
        /// Analog I/O group x status.
        G5S: u1,
        /// Analog I/O group x status.
        G6S: u1,
        /// Analog I/O group x status.
        G7S: u1,
        /// Analog I/O group x status.
        G8S: u1,
        padding: u8 = 0,
    }),
    /// I/O group x counter register.
    /// offset: 0x34
    IOGCR: [6]mmio.Mmio(packed struct(u32) {
        /// Counter value.
        CNT: u14,
        padding: u18 = 0,
    }),
};
