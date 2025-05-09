const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

/// USB Endpoint memory
pub const USBRAM = extern struct {
    /// USB Endpoint memory
    /// offset: 0x00
    MEM: [512]u32,
};
