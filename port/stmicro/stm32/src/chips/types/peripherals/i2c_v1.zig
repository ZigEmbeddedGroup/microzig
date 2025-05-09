const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADDMODE = enum(u1) {
    /// 7-bit addressing mode
    Bit7 = 0x0,
    /// 10-bit addressing mode
    Bit10 = 0x1,
};

pub const DNF = enum(u4) {
    /// Digital filter disabled
    NoFilter = 0x0,
    /// Digital filter enabled and filtering capability up to 1 tI2CCLK
    Filter1 = 0x1,
    /// Digital filter enabled and filtering capability up to 2 tI2CCLK
    Filter2 = 0x2,
    /// Digital filter enabled and filtering capability up to 3 tI2CCLK
    Filter3 = 0x3,
    /// Digital filter enabled and filtering capability up to 4 tI2CCLK
    Filter4 = 0x4,
    /// Digital filter enabled and filtering capability up to 5 tI2CCLK
    Filter5 = 0x5,
    /// Digital filter enabled and filtering capability up to 6 tI2CCLK
    Filter6 = 0x6,
    /// Digital filter enabled and filtering capability up to 7 tI2CCLK
    Filter7 = 0x7,
    /// Digital filter enabled and filtering capability up to 8 tI2CCLK
    Filter8 = 0x8,
    /// Digital filter enabled and filtering capability up to 9 tI2CCLK
    Filter9 = 0x9,
    /// Digital filter enabled and filtering capability up to 10 tI2CCLK
    Filter10 = 0xa,
    /// Digital filter enabled and filtering capability up to 11 tI2CCLK
    Filter11 = 0xb,
    /// Digital filter enabled and filtering capability up to 12 tI2CCLK
    Filter12 = 0xc,
    /// Digital filter enabled and filtering capability up to 13 tI2CCLK
    Filter13 = 0xd,
    /// Digital filter enabled and filtering capability up to 14 tI2CCLK
    Filter14 = 0xe,
    /// Digital filter enabled and filtering capability up to 15 tI2CCLK
    Filter15 = 0xf,
};

pub const DUTY = enum(u1) {
    /// Duty cycle t_low/t_high = 2/1
    Duty2_1 = 0x0,
    /// Duty cycle t_low/t_high = 16/9
    Duty16_9 = 0x1,
};

pub const ENDUAL = enum(u1) {
    /// Single addressing mode
    Single = 0x0,
    /// Dual addressing mode
    Dual = 0x1,
};

pub const F_S = enum(u1) {
    /// Standard mode I2C
    Standard = 0x0,
    /// Fast mode I2C
    Fast = 0x1,
};

pub const POS = enum(u1) {
    /// ACK bit controls the (N)ACK of the current byte being received
    Current = 0x0,
    /// ACK bit controls the (N)ACK of the next byte to be received
    Next = 0x1,
};

pub const SMBTYPE = enum(u1) {
    /// SMBus Device
    Device = 0x0,
    /// SMBus Host
    Host = 0x1,
};

pub const SMBUS = enum(u1) {
    /// I2C Mode
    I2C = 0x0,
    /// SMBus
    SMBus = 0x1,
};

/// Inter-integrated circuit
pub const I2C = extern struct {
    /// Control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Peripheral enable
        PE: u1,
        /// SMBus mode
        SMBUS: SMBUS,
        reserved3: u1 = 0,
        /// SMBus type
        SMBTYPE: SMBTYPE,
        /// ARP enable
        ENARP: u1,
        /// PEC enable
        ENPEC: u1,
        /// General call enable
        ENGC: u1,
        /// Clock stretching disable (Slave mode)
        NOSTRETCH: u1,
        /// Start generation
        START: u1,
        /// Stop generation
        STOP: u1,
        /// Acknowledge enable
        ACK: u1,
        /// Acknowledge/PEC Position (for data reception)
        POS: POS,
        /// Packet error checking
        PEC: u1,
        /// SMBus alert
        ALERT: u1,
        reserved15: u1 = 0,
        /// Software reset
        SWRST: u1,
        padding: u16 = 0,
    }),
    /// Control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Peripheral clock frequency
        FREQ: u6,
        reserved8: u2 = 0,
        /// Error interrupt enable
        ITERREN: u1,
        /// Event interrupt enable
        ITEVTEN: u1,
        /// Buffer interrupt enable
        ITBUFEN: u1,
        /// DMA requests enable
        DMAEN: u1,
        /// DMA last transfer
        LAST: u1,
        padding: u19 = 0,
    }),
    /// Own address register 1
    /// offset: 0x08
    OAR1: mmio.Mmio(packed struct(u32) {
        /// Interface address
        ADD: u10,
        reserved15: u5 = 0,
        /// Addressing mode (slave mode)
        ADDMODE: ADDMODE,
        padding: u16 = 0,
    }),
    /// Own address register 2
    /// offset: 0x0c
    OAR2: mmio.Mmio(packed struct(u32) {
        /// Dual addressing mode enable
        ENDUAL: ENDUAL,
        /// Interface address
        ADD2: u7,
        padding: u24 = 0,
    }),
    /// Data register
    /// offset: 0x10
    DR: mmio.Mmio(packed struct(u32) {
        /// 8-bit data register
        DR: u8,
        padding: u24 = 0,
    }),
    /// Status register 1
    /// offset: 0x14
    SR1: mmio.Mmio(packed struct(u32) {
        /// Start bit (Master mode)
        START: u1,
        /// Address sent (master mode)/matched (slave mode)
        ADDR: u1,
        /// Byte transfer finished
        BTF: u1,
        /// 10-bit header sent (Master mode)
        ADD10: u1,
        /// Stop detection (slave mode)
        STOPF: u1,
        reserved6: u1 = 0,
        /// Data register not empty (receivers)
        RXNE: u1,
        /// Data register empty (transmitters)
        TXE: u1,
        /// Bus error
        BERR: u1,
        /// Arbitration lost (master mode)
        ARLO: u1,
        /// Acknowledge failure
        AF: u1,
        /// Overrun/Underrun
        OVR: u1,
        /// PEC Error in reception
        PECERR: u1,
        reserved14: u1 = 0,
        /// Timeout or t_low detection flag
        TIMEOUT: u1,
        /// SMBus alert
        ALERT: u1,
        padding: u16 = 0,
    }),
    /// Status register 2
    /// offset: 0x18
    SR2: mmio.Mmio(packed struct(u32) {
        /// Master/slave
        MSL: u1,
        /// Bus busy
        BUSY: u1,
        /// Transmitter/receiver
        TRA: u1,
        reserved4: u1 = 0,
        /// General call address (Slave mode)
        GENCALL: u1,
        /// SMBus device default address (Slave mode)
        SMBDEFAULT: u1,
        /// SMBus host header (Slave mode)
        SMBHOST: u1,
        /// Dual flag (Slave mode)
        DUALF: u1,
        /// Packet error checking register
        PEC: u8,
        padding: u16 = 0,
    }),
    /// Clock control register
    /// offset: 0x1c
    CCR: mmio.Mmio(packed struct(u32) {
        /// Clock control register in Fast/Standard mode (Master mode)
        CCR: u12,
        reserved14: u2 = 0,
        /// Fast mode duty cycle
        DUTY: DUTY,
        /// I2C master mode selection
        F_S: F_S,
        padding: u16 = 0,
    }),
    /// TRISE register
    /// offset: 0x20
    TRISE: mmio.Mmio(packed struct(u32) {
        /// Maximum rise time in Fast/Standard mode (Master mode)
        TRISE: u6,
        padding: u26 = 0,
    }),
    /// FLTR register
    /// offset: 0x24
    FLTR: mmio.Mmio(packed struct(u32) {
        /// Digital noise filter
        DNF: DNF,
        /// Analog noise filter
        ANOFF: u1,
        padding: u27 = 0,
    }),
};
