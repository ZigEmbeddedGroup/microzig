//! Register definitions for the Broadcom BCM2711, the SoC of the Raspberry Pi 4 Model B.
//!
//! Broadcom does not publish an SVD for this part, so the peripherals this port touches are
//! written out by hand from the BCM2711 ARM Peripherals datasheet:
//! https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
//!
//! The addresses below are the "low peripheral" view, which is what the firmware selects for a
//! 64 bit kernel: the peripheral window that the datasheet places at 0x7E000000 in VideoCore
//! space is seen by the ARM cores at 0xFE000000.

const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const properties = struct {
    pub const peripheral_base = 0xFE00_0000;
};

/// This chip has no generated interrupt table. The GIC-400 is not driven by this port yet.
pub const interrupts: []const struct {
    name: [:0]const u8,
    index: i16,
    description: ?[:0]const u8,
} = &.{};

pub const peripherals = struct {
    pub const GPIO: *volatile types.GPIO = @ptrFromInt(properties.peripheral_base + 0x0020_0000);
    /// PL011 UART, the one the datasheet calls UART0.
    pub const UART0: *volatile types.PL011 = @ptrFromInt(properties.peripheral_base + 0x0020_1000);
};

pub const types = struct {
    pub const GPIO = extern struct {
        /// Function select. Three bits per pin, ten pins per register.
        GPFSEL: [6]mmio.Mmio(packed struct(u32) {
            FSEL: u30,
            padding: u2,
        }),
        reserved18: u32,
        /// Write a one to drive a pin high. GPSET[0] covers pins 0-31, GPSET[1] pins 32-57.
        GPSET: [2]mmio.Mmio(packed struct(u32) {
            SET: u32,
        }),
        reserved28: u32,
        /// Write a one to drive a pin low.
        GPCLR: [2]mmio.Mmio(packed struct(u32) {
            CLR: u32,
        }),
        reserved34: u32,
        /// Reads the current level of the pins.
        GPLEV: [2]mmio.Mmio(packed struct(u32) {
            LEV: u32,
        }),
        reserved40: u32,
        /// Event detect status, write one to clear.
        GPEDS: [2]mmio.Mmio(packed struct(u32) {
            EDS: u32,
        }),
        reserved4c: u32,
        GPREN: [2]mmio.Mmio(packed struct(u32) { REN: u32 }),
        reserved58: u32,
        GPFEN: [2]mmio.Mmio(packed struct(u32) { FEN: u32 }),
        reserved64: u32,
        GPHEN: [2]mmio.Mmio(packed struct(u32) { HEN: u32 }),
        reserved70: u32,
        GPLEN: [2]mmio.Mmio(packed struct(u32) { LEN: u32 }),
        reserved7c: u32,
        GPAREN: [2]mmio.Mmio(packed struct(u32) { AREN: u32 }),
        reserved88: u32,
        GPAFEN: [2]mmio.Mmio(packed struct(u32) { AFEN: u32 }),
        reserved94: [21]u32,
        /// Pull up / pull down control. Two bits per pin, sixteen pins per register.
        ///
        /// NOTE: this replaces the GPPUD / GPPUDCLK clocked sequence of the BCM2835 and BCM2837.
        /// Code written for the older chips does not carry over.
        GPIO_PUP_PDN_CNTRL_REG: [4]mmio.Mmio(packed struct(u32) {
            PUP_PDN: u32,
        }),
    };

    /// ARM PrimeCell PL011 UART.
    pub const PL011 = extern struct {
        /// Data register.
        DR: mmio.Mmio(packed struct(u32) {
            DATA: u8,
            FE: u1,
            PE: u1,
            BE: u1,
            OE: u1,
            padding: u20,
        }),
        RSRECR: u32,
        reserved8: [4]u32,
        /// Flag register.
        FR: mmio.Mmio(packed struct(u32) {
            CTS: u1,
            DSR: u1,
            DCD: u1,
            /// UART busy transmitting.
            BUSY: u1,
            /// Receive fifo empty.
            RXFE: u1,
            /// Transmit fifo full.
            TXFF: u1,
            /// Receive fifo full.
            RXFF: u1,
            /// Transmit fifo empty.
            TXFE: u1,
            RI: u1,
            padding: u23,
        }),
        reserved20: u32,
        ILPR: u32,
        /// Integer part of the baud rate divisor.
        IBRD: mmio.Mmio(packed struct(u32) {
            IBRD: u16,
            padding: u16,
        }),
        /// Fractional part of the baud rate divisor.
        FBRD: mmio.Mmio(packed struct(u32) {
            FBRD: u6,
            padding: u26,
        }),
        /// Line control register.
        LCRH: mmio.Mmio(packed struct(u32) {
            /// Send break.
            BRK: u1,
            /// Parity enable.
            PEN: u1,
            /// Even parity select.
            EPS: u1,
            /// Two stop bits select.
            STP2: u1,
            /// Enable the fifos.
            FEN: u1,
            /// Word length. 0b11 is eight bits.
            WLEN: u2,
            /// Stick parity select.
            SPS: u1,
            padding: u24,
        }),
        /// Control register.
        CR: mmio.Mmio(packed struct(u32) {
            /// UART enable.
            UARTEN: u1,
            SIREN: u1,
            SIRLP: u1,
            reserved3: u4,
            LBE: u1,
            /// Transmit enable.
            TXE: u1,
            /// Receive enable.
            RXE: u1,
            DTR: u1,
            RTS: u1,
            OUT1: u1,
            OUT2: u1,
            RTSEN: u1,
            CTSEN: u1,
            padding: u16,
        }),
        /// Interrupt fifo level select.
        IFLS: u32,
        /// Interrupt mask set/clear.
        IMSC: mmio.Mmio(packed struct(u32) {
            MASK: u32,
        }),
        RIS: u32,
        MIS: u32,
        /// Interrupt clear register.
        ICR: mmio.Mmio(packed struct(u32) {
            CLEAR: u32,
        }),
        DMACR: u32,
    };
};
