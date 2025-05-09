const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const MODE = enum(u3) {
    /// Normal mode, external pin only, buffer enabled
    NORMAL_EXT_BUFEN = 0x0,
    /// Normal mode, external pin and internal peripherals, buffer enabled
    NORMAL_EXT_INT_BUFEN = 0x1,
    /// Normal mode, external pin only, buffer disabled
    NORMAL_EXT_BUFDIS = 0x2,
    /// Normal mode, internal peripherals only, buffer disabled
    NORMAL_INT_BUFDIS = 0x3,
    /// Sample and hold mode, external pin only, buffer enabled
    SAMPHOLD_EXT_BUFEN = 0x4,
    /// Sample and hold mode, external pin and internal peripherals, buffer enabled
    SAMPHOLD_EXT_INT_BUFEN = 0x5,
    /// Sample and hold mode, external pin and internal peripherals, buffer disabled
    SAMPHOLD_EXT_INT_BUFDIS = 0x6,
    /// Sample and hold mode, internal peripherals only, buffer disabled
    SAMPHOLD_INT_BUFDIS = 0x7,
};

pub const WAVE = enum(u2) {
    /// Wave generation disabled
    Disabled = 0x0,
    /// Noise wave generation enabled
    Noise = 0x1,
    /// Triangle wave generation enabled
    Triangle = 0x2,
    /// Sawtooth wave generation enabled
    Sawtooth = 0x3,
};

/// Digital-to-analog converter
pub const DAC = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of EN) channel enable
        @"EN[0]": u1,
        /// (1/2 of TEN) channel trigger enable
        @"TEN[0]": u1,
        /// (1/2 of TSEL) channel trigger selection
        @"TSEL[0]": u4,
        /// (1/2 of WAVE) channel noise/triangle wave generation enable
        @"WAVE[0]": WAVE,
        /// (1/2 of MAMP) channel mask/amplitude selector
        @"MAMP[0]": u4,
        /// (1/2 of DMAEN) channel DMA enable
        @"DMAEN[0]": u1,
        /// (1/2 of DMAUDRIE) channel DMA Underrun Interrupt enable
        @"DMAUDRIE[0]": u1,
        /// (1/2 of CEN) DAC channel calibration enable
        @"CEN[0]": u1,
        reserved16: u1 = 0,
        /// (2/2 of EN) channel enable
        @"EN[1]": u1,
        /// (2/2 of TEN) channel trigger enable
        @"TEN[1]": u1,
        /// (2/2 of TSEL) channel trigger selection
        @"TSEL[1]": u4,
        /// (2/2 of WAVE) channel noise/triangle wave generation enable
        @"WAVE[1]": WAVE,
        /// (2/2 of MAMP) channel mask/amplitude selector
        @"MAMP[1]": u4,
        /// (2/2 of DMAEN) channel DMA enable
        @"DMAEN[1]": u1,
        /// (2/2 of DMAUDRIE) channel DMA Underrun Interrupt enable
        @"DMAUDRIE[1]": u1,
        /// (2/2 of CEN) DAC channel calibration enable
        @"CEN[1]": u1,
        padding: u1 = 0,
    }),
    /// software trigger register
    /// offset: 0x04
    SWTRIGR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SWTRIG) channel software trigger
        @"SWTRIG[0]": u1,
        /// (2/2 of SWTRIG) channel software trigger
        @"SWTRIG[1]": u1,
        reserved16: u14 = 0,
        /// (1/2 of SWTRIGB) channel software trigger B
        @"SWTRIGB[0]": u1,
        /// (2/2 of SWTRIGB) channel software trigger B
        @"SWTRIGB[1]": u1,
        padding: u14 = 0,
    }),
    /// channel 12-bit right-aligned data holding register
    /// offset: 0x08
    DHR12R: mmio.Mmio(packed struct(u32) {
        /// channel 12-bit right-aligned data
        DHR: u12,
        reserved16: u4 = 0,
        /// channel 12-bit right-aligned data B
        DHRB: u12,
        padding: u4 = 0,
    }),
    /// channel 12-bit left-aligned data holding register
    /// offset: 0x0c
    DHR12L: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// channel 12-bit left-aligned data
        DHR: u12,
        reserved20: u4 = 0,
        /// channel 12-bit left-aligned data B
        DHRB: u12,
    }),
    /// channel 8-bit right-aligned data holding register
    /// offset: 0x10
    DHR8R: mmio.Mmio(packed struct(u32) {
        /// channel 8-bit right-aligned data
        DHR: u8,
        /// channel 8-bit right-aligned data B
        DHRB: u8,
        padding: u16 = 0,
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
        reserved16: u4 = 0,
        /// channel data output B
        DORB: u12,
        padding: u4 = 0,
    }),
    /// status register
    /// offset: 0x34
    SR: mmio.Mmio(packed struct(u32) {
        reserved11: u11 = 0,
        /// (1/2 of DACRDY) channel ready status bit
        @"DACRDY[0]": u1,
        /// (1/2 of DORSTAT) channel output register status bit
        @"DORSTAT[0]": u1,
        /// (1/2 of DMAUDR) channel DMA underrun flag
        @"DMAUDR[0]": u1,
        /// (1/2 of CAL_FLAG) channel calibration offset status
        @"CAL_FLAG[0]": u1,
        /// (1/2 of BWST) channel busy writing sample time flag
        @"BWST[0]": u1,
        reserved27: u11 = 0,
        /// (2/2 of DACRDY) channel ready status bit
        @"DACRDY[1]": u1,
        /// (2/2 of DORSTAT) channel output register status bit
        @"DORSTAT[1]": u1,
        /// (2/2 of DMAUDR) channel DMA underrun flag
        @"DMAUDR[1]": u1,
        /// (2/2 of CAL_FLAG) channel calibration offset status
        @"CAL_FLAG[1]": u1,
        /// (2/2 of BWST) channel busy writing sample time flag
        @"BWST[1]": u1,
    }),
    /// calibration control register
    /// offset: 0x38
    CCR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of OTRIM) channel offset trimming value
        @"OTRIM[0]": u5,
        reserved16: u11 = 0,
        /// (2/2 of OTRIM) channel offset trimming value
        @"OTRIM[1]": u5,
        padding: u11 = 0,
    }),
    /// mode control register
    /// offset: 0x3c
    MCR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of MODE) DAC channel mode
        @"MODE[0]": MODE,
        reserved8: u5 = 0,
        /// (1/2 of DMADOUBLE) channel DMA double data mode.
        @"DMADOUBLE[0]": u1,
        /// (1/2 of SINFORMAT) enable signed format for DAC channel
        @"SINFORMAT[0]": u1,
        reserved14: u4 = 0,
        /// high frequency interface mode selection
        HFSEL: u2,
        /// (2/2 of MODE) DAC channel mode
        @"MODE[1]": MODE,
        reserved24: u5 = 0,
        /// (2/2 of DMADOUBLE) channel DMA double data mode.
        @"DMADOUBLE[1]": u1,
        /// (2/2 of SINFORMAT) enable signed format for DAC channel
        @"SINFORMAT[1]": u1,
        padding: u6 = 0,
    }),
    /// sample and hold sample time register
    /// offset: 0x40
    SHSR: [2]mmio.Mmio(packed struct(u32) {
        /// channel sample time
        TSAMPLE: u10,
        padding: u22 = 0,
    }),
    /// sample and hold hold time register
    /// offset: 0x48
    SHHR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of THOLD) channel hold time
        @"THOLD[0]": u10,
        reserved16: u6 = 0,
        /// (2/2 of THOLD) channel hold time
        @"THOLD[1]": u10,
        padding: u6 = 0,
    }),
    /// sample and hold refresh time register
    /// offset: 0x4c
    SHRR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of TREFRESH) channel refresh time
        @"TREFRESH[0]": u8,
        reserved16: u8 = 0,
        /// (2/2 of TREFRESH) channel refresh time
        @"TREFRESH[1]": u8,
        padding: u8 = 0,
    }),
    /// offset: 0x50
    reserved80: [8]u8,
    /// Sawtooth register
    /// offset: 0x58
    STR: [2]mmio.Mmio(packed struct(u32) {
        /// channel sawtooth reset value.
        RSTDATA: u12,
        /// channel sawtooth direction setting
        DIR: u1,
        reserved16: u3 = 0,
        /// channel sawtooth increment value (12.4 bit format)
        INCDATA: u16,
    }),
    /// Sawtooth Mode register
    /// offset: 0x60
    STMODR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of STRSTTRIGSEL) channel sawtooth reset trigger selection
        @"STRSTTRIGSEL[0]": u4,
        reserved8: u4 = 0,
        /// (1/2 of STINCTRIGSEL) channel sawtooth increment trigger selection
        @"STINCTRIGSEL[0]": u4,
        reserved16: u4 = 0,
        /// (2/2 of STRSTTRIGSEL) channel sawtooth reset trigger selection
        @"STRSTTRIGSEL[1]": u4,
        reserved24: u4 = 0,
        /// (2/2 of STINCTRIGSEL) channel sawtooth increment trigger selection
        @"STINCTRIGSEL[1]": u4,
        padding: u4 = 0,
    }),
};
