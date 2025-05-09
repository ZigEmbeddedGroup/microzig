const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const WAVE = enum(u2) {
    /// Wave generation disabled
    Disabled = 0x0,
    /// Noise wave generation enabled
    Noise = 0x1,
    /// Triangle wave generation enabled
    Triangle = 0x2,
    _,
};

/// Digital-to-analog converter
pub const DAC = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of EN) channel enable
        @"EN[0]": u1,
        /// (1/2 of BOFF) channel output buffer disable
        @"BOFF[0]": u1,
        /// (1/2 of TEN) channel trigger enable
        @"TEN[0]": u1,
        /// (1/2 of TSEL) channel trigger selection
        @"TSEL[0]": u3,
        /// (1/2 of WAVE) channel noise/triangle wave generation enable
        @"WAVE[0]": WAVE,
        /// (1/2 of MAMP) channel mask/amplitude selector
        @"MAMP[0]": u4,
        /// (1/2 of DMAEN) channel DMA enable
        @"DMAEN[0]": u1,
        /// (1/2 of DMAUDRIE) channel DMA Underrun Interrupt enable
        @"DMAUDRIE[0]": u1,
        reserved16: u2 = 0,
        /// (2/2 of EN) channel enable
        @"EN[1]": u1,
        /// (2/2 of BOFF) channel output buffer disable
        @"BOFF[1]": u1,
        /// (2/2 of TEN) channel trigger enable
        @"TEN[1]": u1,
        /// (2/2 of TSEL) channel trigger selection
        @"TSEL[1]": u3,
        /// (2/2 of WAVE) channel noise/triangle wave generation enable
        @"WAVE[1]": WAVE,
        /// (2/2 of MAMP) channel mask/amplitude selector
        @"MAMP[1]": u4,
        /// (2/2 of DMAEN) channel DMA enable
        @"DMAEN[1]": u1,
        /// (2/2 of DMAUDRIE) channel DMA Underrun Interrupt enable
        @"DMAUDRIE[1]": u1,
        padding: u2 = 0,
    }),
    /// software trigger register
    /// offset: 0x04
    SWTRIGR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SWTRIG) channel software trigger
        @"SWTRIG[0]": u1,
        /// (2/2 of SWTRIG) channel software trigger
        @"SWTRIG[1]": u1,
        padding: u30 = 0,
    }),
    /// channel 12-bit right-aligned data holding register
    /// offset: 0x08
    DHR12R: mmio.Mmio(packed struct(u32) {
        /// channel 12-bit right-aligned data
        DHR: u12,
        padding: u20 = 0,
    }),
    /// channel 12-bit left-aligned data holding register
    /// offset: 0x0c
    DHR12L: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// channel 12-bit left-aligned data
        DHR: u12,
        padding: u16 = 0,
    }),
    /// channel 8-bit right-aligned data holding register
    /// offset: 0x10
    DHR8R: mmio.Mmio(packed struct(u32) {
        /// channel 8-bit right-aligned data
        DHR: u8,
        padding: u24 = 0,
    }),
    /// offset: 0x14
    reserved20: [12]u8,
    /// dual 12-bit right-aligned data holding register
    /// offset: 0x20
    DHR12RD: mmio.Mmio(packed struct(u32) {
        /// (1/2 of DHR) channel 12-bit right-aligned data
        @"DHR[0]": u12,
        reserved16: u4 = 0,
        /// (2/2 of DHR) channel 12-bit right-aligned data
        @"DHR[1]": u12,
        padding: u4 = 0,
    }),
    /// dual 12-bit left aligned data holding register
    /// offset: 0x24
    DHR12LD: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// (1/2 of DHR) channel 12-bit left-aligned data
        @"DHR[0]": u12,
        reserved20: u4 = 0,
        /// (2/2 of DHR) channel 12-bit left-aligned data
        @"DHR[1]": u12,
    }),
    /// dual 8-bit right aligned data holding register
    /// offset: 0x28
    DHR8RD: mmio.Mmio(packed struct(u32) {
        /// (1/2 of DHR) channel 8-bit right-aligned data
        @"DHR[0]": u8,
        /// (2/2 of DHR) channel 8-bit right-aligned data
        @"DHR[1]": u8,
        padding: u16 = 0,
    }),
    /// channel data output register
    /// offset: 0x2c
    DOR: [2]mmio.Mmio(packed struct(u32) {
        /// channel data output
        DOR: u12,
        padding: u20 = 0,
    }),
    /// status register
    /// offset: 0x34
    SR: mmio.Mmio(packed struct(u32) {
        reserved13: u13 = 0,
        /// (1/2 of DMAUDR) channel DMA underrun flag
        @"DMAUDR[0]": u1,
        reserved29: u15 = 0,
        /// (2/2 of DMAUDR) channel DMA underrun flag
        @"DMAUDR[1]": u1,
        padding: u2 = 0,
    }),
};
