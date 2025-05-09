const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

/// FDCAN Message RAM
pub const FDCANRAM = extern struct {
    /// FDCAN Message RAM
    /// offset: 0x00
    RAM: [2560]u32,
};
