const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Device Factory programmed 96-bit unique device identifier
pub const UID = extern struct {
    /// Factory programmed 96-bit unique device identifier word 0
    /// offset: 0x00
    UID: [3]u32,
};
