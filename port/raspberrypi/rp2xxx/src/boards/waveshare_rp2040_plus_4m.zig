pub const xosc_freq = 12_000_000;

pub const bootrom = @import("shared/rp2040_bootrom.zig");

comptime {
    _ = bootrom;
}
