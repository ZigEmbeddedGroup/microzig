const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// FDCAN Message RAM
pub const FDCANRAM = extern struct {
    /// 11-bit filter
    /// offset: 0x00
    FLSSA: [28]u32,
    /// 29-bit filter
    /// offset: 0x70
    FLESA: [16]u32,
    /// Rx FIFO 0
    /// offset: 0xb0
    RXFIFO0: [54]u32,
    /// Rx FIFO 1
    /// offset: 0x188
    RXFIFO1: [54]u32,
    /// Tx event FIFO
    /// offset: 0x260
    TXEFIFO: [6]u32,
    /// Tx buffer
    /// offset: 0x278
    TXBUF: [54]u32,
};
