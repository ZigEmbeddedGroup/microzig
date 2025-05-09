const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const ADDMODE = enum(u1) {
    /// 7-bit addressing mode
    Bit7 = 0x0,
    /// 10-bit addressing mode
    Bit10 = 0x1,
};

pub const AUTOEND = enum(u1) {
    /// Software end mode: TC flag is set when NBYTES data are transferred, stretching SCL low
    Software = 0x0,
    /// Automatic end mode: a STOP condition is automatically sent when NBYTES data are transferred
    Automatic = 0x1,
};

pub const DIR = enum(u1) {
    /// Write transfer, slave enters receiver mode
    Write = 0x0,
    /// Read transfer, slave enters transmitter mode
    Read = 0x1,
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

pub const HEADR = enum(u1) {
    /// The master sends the complete 10 bit slave address read sequence
    Complete = 0x0,
    /// The master only sends the 1st 7 bits of the 10 bit address, followed by Read direction
    Partial = 0x1,
};

pub const OAMSK = enum(u3) {
    /// No mask
    NoMask = 0x0,
    /// OA2[1] is masked and don’t care. Only OA2[7:2] are compared
    Mask1 = 0x1,
    /// OA2[2:1] are masked and don’t care. Only OA2[7:3] are compared
    Mask2 = 0x2,
    /// OA2[3:1] are masked and don’t care. Only OA2[7:4] are compared
    Mask3 = 0x3,
    /// OA2[4:1] are masked and don’t care. Only OA2[7:5] are compared
    Mask4 = 0x4,
    /// OA2[5:1] are masked and don’t care. Only OA2[7:6] are compared
    Mask5 = 0x5,
    /// OA2[6:1] are masked and don’t care. Only OA2[7] is compared.
    Mask6 = 0x6,
    /// OA2[7:1] are masked and don’t care. No comparison is done, and all (except reserved) 7-bit received addresses are acknowledged
    Mask7 = 0x7,
};

pub const RELOAD = enum(u1) {
    /// The transfer is completed after the NBYTES data transfer (STOP or RESTART will follow)
    Completed = 0x0,
    /// The transfer is not completed after the NBYTES data transfer (NBYTES will be reloaded)
    NotCompleted = 0x1,
};

/// Inter-integrated circuit
pub const I2C = extern struct {
    /// Control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Peripheral enable
        PE: u1,
        /// TX Interrupt enable
        TXIE: u1,
        /// RX Interrupt enable
        RXIE: u1,
        /// Address match interrupt enable (slave only)
        ADDRIE: u1,
        /// Not acknowledge received interrupt enable
        NACKIE: u1,
        /// STOP detection Interrupt enable
        STOPIE: u1,
        /// Transfer Complete interrupt enable
        TCIE: u1,
        /// Error interrupts enable
        ERRIE: u1,
        /// Digital noise filter
        DNF: DNF,
        /// Analog noise filter OFF
        ANFOFF: u1,
        reserved14: u1 = 0,
        /// DMA transmission requests enable
        TXDMAEN: u1,
        /// DMA reception requests enable
        RXDMAEN: u1,
        /// Slave byte control
        SBC: u1,
        /// Clock stretching disable
        NOSTRETCH: u1,
        reserved19: u1 = 0,
        /// General call enable
        GCEN: u1,
        /// SMBus Host address enable
        SMBHEN: u1,
        /// SMBus Device Default address enable
        SMBDEN: u1,
        /// SMBUS alert enable
        ALERTEN: u1,
        /// PEC enable
        PECEN: u1,
        padding: u8 = 0,
    }),
    /// Control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Slave address bit (master mode)
        SADD: u10,
        /// Transfer direction (master mode)
        DIR: DIR,
        /// 10-bit addressing mode (master mode)
        ADD10: ADDMODE,
        /// 10-bit address header only read direction (master receiver mode)
        HEAD10R: HEADR,
        /// Start generation
        START: u1,
        /// Stop generation (master mode)
        STOP: u1,
        /// NACK generation (slave mode)
        NACK: u1,
        /// Number of bytes
        NBYTES: u8,
        /// NBYTES reload mode
        RELOAD: RELOAD,
        /// Automatic end mode (master mode)
        AUTOEND: AUTOEND,
        /// Packet error checking byte
        PECBYTE: u1,
        padding: u5 = 0,
    }),
    /// Own address register 1
    /// offset: 0x08
    OAR1: mmio.Mmio(packed struct(u32) {
        /// Interface address
        OA1: u10,
        /// Own Address 1 10-bit mode
        OA1MODE: ADDMODE,
        reserved15: u4 = 0,
        /// Own Address 1 enable
        OA1EN: u1,
        padding: u16 = 0,
    }),
    /// Own address register 2
    /// offset: 0x0c
    OAR2: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Interface address
        OA2: u7,
        /// Own Address 2 masks
        OA2MSK: OAMSK,
        reserved15: u4 = 0,
        /// Own Address 2 enable
        OA2EN: u1,
        padding: u16 = 0,
    }),
    /// Timing register
    /// offset: 0x10
    TIMINGR: mmio.Mmio(packed struct(u32) {
        /// SCL low period (master mode)
        SCLL: u8,
        /// SCL high period (master mode)
        SCLH: u8,
        /// Data hold time
        SDADEL: u4,
        /// Data setup time
        SCLDEL: u4,
        reserved28: u4 = 0,
        /// Timing prescaler
        PRESC: u4,
    }),
    /// Timeout register
    /// offset: 0x14
    TIMEOUTR: mmio.Mmio(packed struct(u32) {
        /// Bus timeout A
        TIMEOUTA: u12,
        /// Idle clock timeout detection
        TIDLE: u1,
        reserved15: u2 = 0,
        /// Clock timeout enable
        TIMOUTEN: u1,
        /// Bus timeout B
        TIMEOUTB: u12,
        reserved31: u3 = 0,
        /// Extended clock timeout enable
        TEXTEN: u1,
    }),
    /// Interrupt and Status register
    /// offset: 0x18
    ISR: mmio.Mmio(packed struct(u32) {
        /// Transmit data register empty (transmitters)
        TXE: u1,
        /// Transmit interrupt status (transmitters)
        TXIS: u1,
        /// Receive data register not empty (receivers)
        RXNE: u1,
        /// Address matched (slave mode)
        ADDR: u1,
        /// Not acknowledge received flag
        NACKF: u1,
        /// Stop detection flag
        STOPF: u1,
        /// Transfer Complete (master mode)
        TC: u1,
        /// Transfer Complete Reload
        TCR: u1,
        /// Bus error
        BERR: u1,
        /// Arbitration lost
        ARLO: u1,
        /// Overrun/Underrun (slave mode)
        OVR: u1,
        /// PEC Error in reception
        PECERR: u1,
        /// Timeout or t_low detection flag
        TIMEOUT: u1,
        /// SMBus alert
        ALERT: u1,
        reserved15: u1 = 0,
        /// Bus busy
        BUSY: u1,
        /// Transfer direction (Slave mode)
        DIR: DIR,
        /// Address match code (Slave mode)
        ADDCODE: u7,
        padding: u8 = 0,
    }),
    /// Interrupt clear register
    /// offset: 0x1c
    ICR: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Address Matched flag clear
        ADDRCF: u1,
        /// Not Acknowledge flag clear
        NACKCF: u1,
        /// Stop detection flag clear
        STOPCF: u1,
        reserved8: u2 = 0,
        /// Bus error flag clear
        BERRCF: u1,
        /// Arbitration lost flag clear
        ARLOCF: u1,
        /// Overrun/Underrun flag clear
        OVRCF: u1,
        /// PEC Error flag clear
        PECCF: u1,
        /// Timeout detection flag clear
        TIMOUTCF: u1,
        /// Alert flag clear
        ALERTCF: u1,
        padding: u18 = 0,
    }),
    /// PEC register
    /// offset: 0x20
    PECR: mmio.Mmio(packed struct(u32) {
        /// Packet error checking register
        PEC: u8,
        padding: u24 = 0,
    }),
    /// Receive data register
    /// offset: 0x24
    RXDR: mmio.Mmio(packed struct(u32) {
        /// 8-bit receive data
        RXDATA: u8,
        padding: u24 = 0,
    }),
    /// Transmit data register
    /// offset: 0x28
    TXDR: mmio.Mmio(packed struct(u32) {
        /// 8-bit transmit data
        TXDATA: u8,
        padding: u24 = 0,
    }),
};
