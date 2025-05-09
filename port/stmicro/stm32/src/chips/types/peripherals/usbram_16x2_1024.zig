const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// USB Endpoint memory
pub const USBRAM = extern struct {
    /// USB Endpoint memory
    /// offset: 0x00
    MEM: u32,
};
