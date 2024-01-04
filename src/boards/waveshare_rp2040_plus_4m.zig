pub const xosc_freq = 12_000_000;

comptime {
    _ = @import("shared/bootrom.zig");
}
