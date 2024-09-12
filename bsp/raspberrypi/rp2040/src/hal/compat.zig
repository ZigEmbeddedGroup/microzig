const std = @import("std");
const microzig = @import("microzig");

pub const CPU = enum {
    RP2040,
    RP2350,
};

pub fn forCPU(comptime cpu: CPU) bool {
    return switch (cpu) {
        .RP2040 => std.mem.eql(u8, microzig.config.chip_name, "RP2040"),
        .RP2350 => std.mem.eql(u8, microzig.config.chip_name, "RP2350"),
    };
}
