const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// Digital camera interface
pub const DCMI = extern struct {
    /// control register 1
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Capture enable
        CAPTURE: u1,
        /// Capture mode
        CM: u1,
        /// Crop feature
        CROP: u1,
        /// JPEG format
        JPEG: u1,
        /// Embedded synchronization select
        ESS: u1,
        /// Pixel clock polarity
        PCKPOL: u1,
        /// Horizontal synchronization polarity
        HSPOL: u1,
        /// Vertical synchronization polarity
        VSPOL: u1,
        /// Frame capture rate control
        FCRC: u2,
        /// Extended data mode
        EDM: u2,
        reserved14: u2 = 0,
        /// DCMI enable
        ENABLE: u1,
        padding: u17 = 0,
    }),
    /// status register
    /// offset: 0x04
    SR: mmio.Mmio(packed struct(u32) {
        /// HSYNC
        HSYNC: u1,
        /// VSYNC
        VSYNC: u1,
        /// FIFO not empty
        FNE: u1,
        padding: u29 = 0,
    }),
    /// raw interrupt status register
    /// offset: 0x08
    RIS: mmio.Mmio(packed struct(u32) {
        /// Capture complete raw interrupt status
        FRAME_RIS: u1,
        /// Overrun raw interrupt status
        OVR_RIS: u1,
        /// Synchronization error raw interrupt status
        ERR_RIS: u1,
        /// VSYNC raw interrupt status
        VSYNC_RIS: u1,
        /// Line raw interrupt status
        LINE_RIS: u1,
        padding: u27 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x0c
    IER: mmio.Mmio(packed struct(u32) {
        /// Capture complete interrupt enable
        FRAME_IE: u1,
        /// Overrun interrupt enable
        OVR_IE: u1,
        /// Synchronization error interrupt enable
        ERR_IE: u1,
        /// VSYNC interrupt enable
        VSYNC_IE: u1,
        /// Line interrupt enable
        LINE_IE: u1,
        padding: u27 = 0,
    }),
    /// masked interrupt status register
    /// offset: 0x10
    MIS: mmio.Mmio(packed struct(u32) {
        /// Capture complete masked interrupt status
        FRAME_MIS: u1,
        /// Overrun masked interrupt status
        OVR_MIS: u1,
        /// Synchronization error masked interrupt status
        ERR_MIS: u1,
        /// VSYNC masked interrupt status
        VSYNC_MIS: u1,
        /// Line masked interrupt status
        LINE_MIS: u1,
        padding: u27 = 0,
    }),
    /// interrupt clear register
    /// offset: 0x14
    ICR: mmio.Mmio(packed struct(u32) {
        /// Capture complete interrupt status clear
        FRAME_ISC: u1,
        /// Overrun interrupt status clear
        OVR_ISC: u1,
        /// Synchronization error interrupt status clear
        ERR_ISC: u1,
        /// Vertical synch interrupt status clear
        VSYNC_ISC: u1,
        /// line interrupt status clear
        LINE_ISC: u1,
        padding: u27 = 0,
    }),
    /// embedded synchronization code register
    /// offset: 0x18
    ESCR: mmio.Mmio(packed struct(u32) {
        /// Frame start delimiter code
        FSC: u8,
        /// Line start delimiter code
        LSC: u8,
        /// Line end delimiter code
        LEC: u8,
        /// Frame end delimiter code
        FEC: u8,
    }),
    /// embedded synchronization unmask register
    /// offset: 0x1c
    ESUR: mmio.Mmio(packed struct(u32) {
        /// Frame start delimiter unmask
        FSU: u8,
        /// Line start delimiter unmask
        LSU: u8,
        /// Line end delimiter unmask
        LEU: u8,
        /// Frame end delimiter unmask
        FEU: u8,
    }),
    /// crop window start
    /// offset: 0x20
    CWSTRT: mmio.Mmio(packed struct(u32) {
        /// Horizontal offset count
        HOFFCNT: u14,
        reserved16: u2 = 0,
        /// Vertical start line count
        VST: u13,
        padding: u3 = 0,
    }),
    /// crop window size
    /// offset: 0x24
    CWSIZE: mmio.Mmio(packed struct(u32) {
        /// Capture count
        CAPCNT: u14,
        reserved16: u2 = 0,
        /// Vertical line count
        VLINE: u14,
        padding: u2 = 0,
    }),
    /// data register
    /// offset: 0x28
    DR: mmio.Mmio(packed struct(u32) {
        /// Data byte 0
        Byte0: u8,
        /// Data byte 1
        Byte1: u8,
        /// Data byte 2
        Byte2: u8,
        /// Data byte 3
        Byte3: u8,
    }),
};
