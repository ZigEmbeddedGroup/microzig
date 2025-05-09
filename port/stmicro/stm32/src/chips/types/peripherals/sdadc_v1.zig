const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// Sigma-delta analog-to-digital converter.
pub const SDADC = extern struct {
    /// control register 1.
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// End of calibration interrupt enable.
        EOCALIE: u1,
        /// Injected end of conversion interrupt enable.
        JEOCIE: u1,
        /// Injected data overrun interrupt enable.
        JOVRIE: u1,
        /// Regular end of conversion interrupt enable.
        REOCIE: u1,
        /// Regular data overrun interrupt enable.
        ROVRIE: u1,
        reserved8: u3 = 0,
        /// Reference voltage selection.
        REFV: u2,
        /// Slow clock mode enable.
        SLOWCK: u1,
        /// Enter Standby mode when idle.
        SBI: u1,
        /// Enter power down mode when idle.
        PDI: u1,
        reserved14: u1 = 0,
        /// Launch a injected conversion synchronously with SDADC1.
        JSYNC: u1,
        /// Launch regular conversion synchronously with SDADC1.
        RSYNC: u1,
        /// DMA channel enabled to read data for the injected channel group.
        JDMAEN: u1,
        /// DMA channel enabled to read data for the regular channel.
        RDMAEN: u1,
        reserved31: u13 = 0,
        /// Initialization mode request.
        INIT: u1,
    }),
    /// control register 2.
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// SDADC enable.
        ADON: u1,
        /// Number of calibration sequences to be performed (number of valid configurations).
        CALIBCNT: u2,
        reserved4: u1 = 0,
        /// Start calibration.
        STARTCALIB: u1,
        /// Continuous mode selection for injected conversions.
        JCONT: u1,
        /// Delay start of injected conversions.
        JDS: u1,
        reserved8: u1 = 0,
        /// Trigger signal selection for launching injected conversions.
        JEXTSEL: u4,
        reserved13: u1 = 0,
        /// Trigger enable and trigger edge selection for injected conversions.
        JEXTEN: u2,
        /// Start a conversion of the injected group of channels.
        JSWSTART: u1,
        /// Regular channel selection.
        RCH: u4,
        reserved22: u2 = 0,
        /// Continuous mode selection for regular conversions.
        RCONT: u1,
        /// Software start of a conversion on the regular channel.
        RSWSTART: u1,
        /// Fast conversion mode selection.
        FAST: u1,
        padding: u7 = 0,
    }),
    /// interrupt and status register.
    /// offset: 0x08
    ISR: mmio.Mmio(packed struct(u32) {
        /// End of calibration flag.
        EOCALF: u1,
        /// End of injected conversion flag.
        JEOCF: u1,
        /// Injected conversion overrun flag.
        JOVRF: u1,
        /// End of regular conversion flag.
        REOCF: u1,
        /// Regular conversion overrun flag.
        ROVRF: u1,
        reserved12: u7 = 0,
        /// Calibration in progress status.
        CALIBIP: u1,
        /// Injected conversion in progress status.
        JCIP: u1,
        /// Regular conversion in progress status.
        RCIP: u1,
        /// Stabilization in progress status.
        STABIP: u1,
        reserved31: u15 = 0,
        /// Initialization mode is ready.
        INITRDY: u1,
    }),
    /// interrupt and status clear register.
    /// offset: 0x0c
    CLRISR: mmio.Mmio(packed struct(u32) {
        /// Clear the end of calibration flag.
        CLREOCALF: u1,
        reserved2: u1 = 0,
        /// Clear the injected conversion overrun flag.
        CLRJOVRF: u1,
        reserved4: u1 = 0,
        /// Clear the regular conversion overrun flag.
        CLRROVRF: u1,
        padding: u27 = 0,
    }),
    /// offset: 0x10
    reserved16: [4]u8,
    /// injected channel group selection register.
    /// offset: 0x14
    JCHGR: mmio.Mmio(packed struct(u32) {
        /// Injected channel group selection.
        JCHG: u9,
        padding: u23 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// configuration 0 register.
    /// offset: 0x20
    CONFR: [3]mmio.Mmio(packed struct(u32) {
        /// Twelve-bit calibration offset for configuration 0.
        OFFSET: u12,
        reserved20: u8 = 0,
        /// Gain setting for configuration 0.
        GAIN: u3,
        reserved26: u3 = 0,
        /// Single-ended mode for configuration 0.
        SE: u2,
        reserved30: u2 = 0,
        /// Common mode for configuration 0.
        COMMON: u2,
    }),
    /// offset: 0x2c
    reserved44: [20]u8,
    /// channel configuration register 1.
    /// offset: 0x40
    CONFCHR1: mmio.Mmio(packed struct(u32) {
        /// (1/8 of CONFCH) CONFCH0.
        @"CONFCH[0]": u2,
        reserved4: u2 = 0,
        /// (2/8 of CONFCH) CONFCH0.
        @"CONFCH[1]": u2,
        reserved8: u2 = 0,
        /// (3/8 of CONFCH) CONFCH0.
        @"CONFCH[2]": u2,
        reserved12: u2 = 0,
        /// (4/8 of CONFCH) CONFCH0.
        @"CONFCH[3]": u2,
        reserved16: u2 = 0,
        /// (5/8 of CONFCH) CONFCH0.
        @"CONFCH[4]": u2,
        reserved20: u2 = 0,
        /// (6/8 of CONFCH) CONFCH0.
        @"CONFCH[5]": u2,
        reserved24: u2 = 0,
        /// (7/8 of CONFCH) CONFCH0.
        @"CONFCH[6]": u2,
        reserved28: u2 = 0,
        /// (8/8 of CONFCH) CONFCH0.
        @"CONFCH[7]": u2,
        padding: u2 = 0,
    }),
    /// channel configuration register 2.
    /// offset: 0x44
    CONFCHR2: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CONFCH) Channel 8 configuration.
        @"CONFCH[0]": u2,
        padding: u30 = 0,
    }),
    /// offset: 0x48
    reserved72: [24]u8,
    /// data register for injected group.
    /// offset: 0x60
    JDATAR: mmio.Mmio(packed struct(u32) {
        /// Injected group conversion data.
        JDATA: u16,
        reserved24: u8 = 0,
        /// Injected channel most recently converted.
        JDATACH: u4,
        padding: u4 = 0,
    }),
    /// data register for the regular channel.
    /// offset: 0x64
    RDATAR: mmio.Mmio(packed struct(u32) {
        /// Regular channel conversion data.
        RDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x68
    reserved104: [8]u8,
    /// SDADC1 and SDADC2 injected data register.
    /// offset: 0x70
    JDATA12R: u32,
    /// SDADC1 and SDADC2 regular data register.
    /// offset: 0x74
    RDATA12R: u32,
    /// SDADC1 and SDADC3 injected data register.
    /// offset: 0x78
    JDATA13R: u32,
    /// SDADC1 and SDADC3 regular data register.
    /// offset: 0x7c
    RDATA13R: u32,
};
