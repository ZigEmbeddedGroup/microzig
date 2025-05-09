const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const POL = enum(u2) {
    /// No event, i.e. no synchronization nor detection
    NoEdge = 0x0,
    /// Rising edge
    RisingEdge = 0x1,
    /// Falling edge
    FallingEdge = 0x2,
    /// Rising and falling edges
    BothEdges = 0x3,
};

/// DMAMUX
pub const DMAMUX = extern struct {
    /// DMAMux - DMA request line multiplexer channel x control register
    /// offset: 0x00
    CCR: [16]mmio.Mmio(packed struct(u32) {
        /// Input DMA request line selected
        DMAREQ_ID: u8,
        /// Interrupt enable at synchronization event overrun
        SOIE: u1,
        /// Event generation enable/disable
        EGE: u1,
        reserved16: u6 = 0,
        /// Synchronous operating mode enable/disable
        SE: u1,
        /// Synchronization event type selector Defines the synchronization event on the selected synchronization input:
        SPOL: POL,
        /// Number of DMA requests to forward Defines the number of DMA requests forwarded before output event is generated. In synchronous mode, it also defines the number of DMA requests to forward after a synchronization event, then stop forwarding. The actual number of DMA requests forwarded is NBREQ+1. Note: This field can only be written when both SE and EGE bits are reset.
        NBREQ: u5,
        /// Synchronization input selected
        SYNC_ID: u5,
        padding: u3 = 0,
    }),
    /// offset: 0x40
    reserved64: [64]u8,
    /// DMAMUX request line multiplexer interrupt channel status register
    /// offset: 0x80
    CSR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of SOF) Synchronization overrun event flag
        @"SOF[0]": u1,
        /// (2/16 of SOF) Synchronization overrun event flag
        @"SOF[1]": u1,
        /// (3/16 of SOF) Synchronization overrun event flag
        @"SOF[2]": u1,
        /// (4/16 of SOF) Synchronization overrun event flag
        @"SOF[3]": u1,
        /// (5/16 of SOF) Synchronization overrun event flag
        @"SOF[4]": u1,
        /// (6/16 of SOF) Synchronization overrun event flag
        @"SOF[5]": u1,
        /// (7/16 of SOF) Synchronization overrun event flag
        @"SOF[6]": u1,
        /// (8/16 of SOF) Synchronization overrun event flag
        @"SOF[7]": u1,
        /// (9/16 of SOF) Synchronization overrun event flag
        @"SOF[8]": u1,
        /// (10/16 of SOF) Synchronization overrun event flag
        @"SOF[9]": u1,
        /// (11/16 of SOF) Synchronization overrun event flag
        @"SOF[10]": u1,
        /// (12/16 of SOF) Synchronization overrun event flag
        @"SOF[11]": u1,
        /// (13/16 of SOF) Synchronization overrun event flag
        @"SOF[12]": u1,
        /// (14/16 of SOF) Synchronization overrun event flag
        @"SOF[13]": u1,
        /// (15/16 of SOF) Synchronization overrun event flag
        @"SOF[14]": u1,
        /// (16/16 of SOF) Synchronization overrun event flag
        @"SOF[15]": u1,
        padding: u16 = 0,
    }),
    /// DMAMUX request line multiplexer interrupt clear flag register
    /// offset: 0x84
    CFR: mmio.Mmio(packed struct(u32) {
        /// (1/16 of SOF) Synchronization overrun event flag
        @"SOF[0]": u1,
        /// (2/16 of SOF) Synchronization overrun event flag
        @"SOF[1]": u1,
        /// (3/16 of SOF) Synchronization overrun event flag
        @"SOF[2]": u1,
        /// (4/16 of SOF) Synchronization overrun event flag
        @"SOF[3]": u1,
        /// (5/16 of SOF) Synchronization overrun event flag
        @"SOF[4]": u1,
        /// (6/16 of SOF) Synchronization overrun event flag
        @"SOF[5]": u1,
        /// (7/16 of SOF) Synchronization overrun event flag
        @"SOF[6]": u1,
        /// (8/16 of SOF) Synchronization overrun event flag
        @"SOF[7]": u1,
        /// (9/16 of SOF) Synchronization overrun event flag
        @"SOF[8]": u1,
        /// (10/16 of SOF) Synchronization overrun event flag
        @"SOF[9]": u1,
        /// (11/16 of SOF) Synchronization overrun event flag
        @"SOF[10]": u1,
        /// (12/16 of SOF) Synchronization overrun event flag
        @"SOF[11]": u1,
        /// (13/16 of SOF) Synchronization overrun event flag
        @"SOF[12]": u1,
        /// (14/16 of SOF) Synchronization overrun event flag
        @"SOF[13]": u1,
        /// (15/16 of SOF) Synchronization overrun event flag
        @"SOF[14]": u1,
        /// (16/16 of SOF) Synchronization overrun event flag
        @"SOF[15]": u1,
        padding: u16 = 0,
    }),
    /// offset: 0x88
    reserved136: [120]u8,
    /// DMAMux - DMA request generator channel x control register
    /// offset: 0x100
    RGCR: [8]mmio.Mmio(packed struct(u32) {
        /// DMA request trigger input selected
        SIG_ID: u5,
        reserved8: u3 = 0,
        /// Interrupt enable at trigger event overrun
        OIE: u1,
        reserved16: u7 = 0,
        /// DMA request generator channel enable/disable
        GE: u1,
        /// DMA request generator trigger event type selection Defines the trigger event on the selected DMA request trigger input
        GPOL: POL,
        /// Number of DMA requests to generate Defines the number of DMA requests generated after a trigger event, then stop generating. The actual number of generated DMA requests is GNBREQ+1. Note: This field can only be written when GE bit is reset.
        GNBREQ: u5,
        padding: u8 = 0,
    }),
    /// offset: 0x120
    reserved288: [32]u8,
    /// DMAMux - DMA request generator status register
    /// offset: 0x140
    RGSR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[0]": u1,
        /// (2/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[1]": u1,
        /// (3/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[2]": u1,
        /// (4/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[3]": u1,
        /// (5/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[4]": u1,
        /// (6/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[5]": u1,
        /// (7/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[6]": u1,
        /// (8/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[7]": u1,
        padding: u24 = 0,
    }),
    /// DMAMux - DMA request generator clear flag register
    /// offset: 0x144
    RGCFR: mmio.Mmio(packed struct(u32) {
        /// (1/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[0]": u1,
        /// (2/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[1]": u1,
        /// (3/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[2]": u1,
        /// (4/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[3]": u1,
        /// (5/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[4]": u1,
        /// (6/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[5]": u1,
        /// (7/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[6]": u1,
        /// (8/8 of OF) Trigger event overrun flag The flag is set when a trigger event occurs on DMA request generator channel x, while the DMA request generator counter value is lower than GNBREQ. The flag is cleared by writing 1 to the corresponding COFx bit in DMAMUX_RGCFR register.
        @"OF[7]": u1,
        padding: u24 = 0,
    }),
};
